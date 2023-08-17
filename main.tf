module "my_vpc" {
  source   = "./modules/aws_vpc"
  for_each = var.vpc_variables
  vpc_cidr_block = each.value.vpc_cidr_block
  tags     = each.value.tags

}

module "my_subnets" {
  source            = "./modules/aws_subnets"
  for_each          = var.subnet_variables
  subnet_cidr_block       = each.value.subnet_cidr_block
  tags              = each.value.tags
  vpc_id            = module.my_vpc[each.value.vpc_name].vpc_id
  availability_zone = each.value.availability_zone
}

module "internetGW_module" {
  source = "./modules/aws_internetGW"
  for_each = var.internetGW_variables
  vpc_id = module.my_vpc[each.value.vpc_name].vpc_id
  tags = each.value.tags
}

module "natGW_module" {
  source = "./modules/aws_natGW"
  for_each = var.natGW_variables
  eip_id = module.eip_module[each.value.eip_name].eip_id
  subnet_id = module.my_subnets[each.value.subnet_name].subnet_id
  tags = each.value.tags
}

module "eip_module" {
  source = "./modules/aws_eip"
  for_each = var.eip_variables
  tags = each.value.tags
  
}
module "RT_module" {
  source = "./modules/aws_RT"
  for_each = var.RT_Variables
  vpc_id = module.my_vpc[each.value.vpc_name].vpc_id
  GW_id = each.value.private == 0? module.internetGW_module[each.value.gateway_name].internetGW_id : module.natGW_module[each.value.gateway_name].natGW_id
  tags = each.value.tags
  
}
module "RTassociation_module" {
  source = "./modules/aws_RTassociation"
  for_each = var.RTassociation_variables
  subnet_id = module.my_subnets[each.value.subnet_name].subnet_id
  route_table_id = module.RT_module[each.value.route_table_name].RT_id
  
}

module "eks_module" {
  source = "./modules/aws_eks"
  for_each = var.eks_variables
  eks_cluster_name = each.value.eks_cluster_name
  subnet_ids = [module.my_subnets[each.value.subnet1].subnet_id,module.my_subnets[each.value.subnet2].subnet_id,module.my_subnets[each.value.subnet3].subnet_id,module.my_subnets[each.value.subnet4].subnet_id]
  
}

module "nodegroup_module" {
  source = "./modules/aws_nodegroup"
  for_each = var.nodegroup_variables
  cluster_name = each.value.cluster_name
  node_group_name = each.value.node_group_name
  subnet_ids = [module.my_subnets[each.value.subnet1].subnet_id,module.my_subnets[each.value.subnet2].subnet_id]
  role_name = each.value.role_name
}

