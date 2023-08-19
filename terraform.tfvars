region = "us-east-1"
access_key = ""
secret_key = ""







vpc_variables = {
  "vpc1" = {
    vpc_cidr_block = "10.0.0.0/24"
    tags = {
      Name = "my_vpc"
    }
  }
}

subnet_variables = {
  "public-subnet-1" = {
    subnet_cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "public-subnet-1"
    }
    vpc_name = "vpc1"
  }
  "public-subnet-2" = {
    subnet_cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "public-subnet-2"
    }
    vpc_name = "vpc1"
  }
  "private-subnet-1" = {
    subnet_cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "private-subnet-1"
    }
    vpc_name = "vpc1"
  }
  "private-subnet-2" = {
    subnet_cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "private-subnet-2"
    }
    vpc_name = "vpc1"
  }
}

internetGW_variables = {
  igw1 = {
    vpc_name = "vpc1"
    tags = {
      Name = "My_IGW"
    }
  }
}

eip_variables = {
  eip1 = {
    tags = {
      Name = "nat1"
    }
  }
  eip2 = {
    tags = {
      Name = "nat2"
    }
  }
}


natGW_variables = {
  nat1 = {
    eip_name = "eip1"
    subnet_name = "public-subnet-1"
    tags = {
      Name = "nat1"
    }
  }
  nat2 = {
    eip_name = "eip2"
    subnet_name = "public-subnet-2"
    tags = {
      Name = "nat2"
    }
  }
}

RT_Variables = {
  RT1 = {
    private = 0
    vpc_name = "vpc1"
    gateway_name = "igw1"
    tags = {
      Name = "public-RT"
    }
  }
  RT2 = {
    private = 1
    vpc_name = "vpc1"
    gateway_name = "nat1"
    tags = {
      Name = "private-RT1"
    }
  }
  RT3 = {
    private = 1
    vpc_name = "vpc1"
    gateway_name = "nat2"
    tags = {
      Name = "private-RT2"
    }
  }
}

RTassociation_variables = {
  RTasso1 = {
    subnet_name = "public-subnet-1"
    route_table_name = "RT1"
  }
  RTasso2 = {
    subnet_name = "public-subnet-2"
    route_table_name = "RT1"
  }
  RTasso3 = {
    subnet_name = "private-subnet-1"
    route_table_name = "RT2"
  }
  RTasso4 = {
    subnet_name = "private-subnet-2"
    route_table_name = "RT3"
  }
}

eks_variables = {
  eks1 = {
    eks_cluster_name = "eks1"
    subnet1 = "public-subnet-1"
    subnet2 = "public-subnet-2"
    subnet3 = "private-subnet-1"
    subnet4 = "private-subnet-2"

  }
}

nodegroup_variables = {
  node1 = {
    cluster_name = "eks1"
    node_group_name = "node1"
    subnet1 = "private-subnet-1"
    subnet2 = "private-subnet-2"
    role_name = "node_group-1"
    


  }
  node2 = {
    cluster_name = "eks1"
    node_group_name = "node2"
    subnet1 = "private-subnet-1"
    subnet2 = "private-subnet-2"
    role_name = "node_group-1"

  }
}


