# resource "awscc_opensearchserverless_collection" "os" {
#   name = local.collection_name
#   #https://docs.aws.amazon.com/opensearch-service/latest/ServerlessAPIReference/API_CreateCollection.html
#   type = "SEARCH"

#   depends_on = [
#     awscc_opensearchserverless_security_policy.encryption
#   ]
# }


# resource "awscc_opensearchserverless_security_policy" "encryption" {
#   name        = "test-encryption-policy"
#   description = "test"
#   policy = jsonencode(
#     {
#       "Rules" : [
#         {
#           "ResourceType" : "collection",
#           "Resource" : [
#             "collection/test"
#           ]
#         }
#       ],
#       "AWSOwnedKey" : true
#     }
#   )
#   type = "encryption"
# }

resource "awscc_opensearchserverless_security_policy" "network" {
  name = "quickstart-network-policy"
  description = "quickstart-network-policy-desc-changed"
  policy = jsonencode(
    [
      {
        "Rules" : [
          {
            "ResourceType" : "dashboard",
            "Resource" : [
              "collection/quickstart"
            ]
          },
          {
            "ResourceType" : "collection",
            "Resource" : [
              "collection/quickstart"
            ]
          }
        ],
        "AllowFromPublic" : true
      }
    ]
  )
  type = "network"

   lifecycle {
    ignore_changes = [
      policy,
    ]
  }
}

# resource "awscc_opensearchserverless_vpc_endpoint" "os_vpc" {
#   name = "opensearch-vpc-endpoint"
#   vpc_id = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets  #private subnets from which we want to access this endpoint
# }
