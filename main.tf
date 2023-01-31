resource "awscc_opensearchserverless_collection" "os" {
  name = local.collection_name
  #https://docs.aws.amazon.com/opensearch-service/latest/ServerlessAPIReference/API_CreateCollection.html
  type = "SEARCH"

  depends_on = [
    awscc_opensearchserverless_security_policy.encryption
  ]
}


resource "awscc_opensearchserverless_security_policy" "encryption" {
  name = "s3-inventory-encryption-policy"
#   description = "Encryption policy"
  policy = jsonencode(
    {
      "Rules" : [
        {
          "ResourceType" : "collection",
          "Resource" : [
            "collection/${local.collection_name}"
          ]
        }
      ],
      "AWSOwnedKey" : true
    }
  )
  type = "encryption"
}

resource "awscc_opensearchserverless_security_policy" "network" {
  name = "s3-inventory-network-policy"
#   description = "Network policy"
  policy = jsonencode(
    [
      {
        "Rules" : [
          {
            "ResourceType" : "dashboard",
            "Resource" : [
              "collection/${local.collection_name}"
            ]
          },
          {
            "ResourceType" : "collection",
            "Resource" : [
              "collection/${local.collection_name}"
            ]
          }
        ],
        "AllowFromPublic" : true
      }
    ]
  )
  type = "network"
}

# resource "awscc_opensearchserverless_vpc_endpoint" "os_vpc" {
#   name = "opensearch-vpc-endpoint"
#   vpc_id = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets  #private subnets from which we want to access this endpoint
# }
