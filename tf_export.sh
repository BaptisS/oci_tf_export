complist=$(oci iam compartment list --all --compartment-id-in-subtree true) 
complistcur=$(echo $complist | jq .data | jq -r '.[] | ."id"')
mkdir $HOME/resource-discovery
cd $HOME/resource-discovery
for compocid in $complistcur;do compname=$(oci iam compartment get --compartment-id $compocid --query 'data."name"' | jq -r) && mkdir $compname && terraform-provider-oci_v5.5.0 -command=export -compartment_id=$compocid -services=core -generate_state -output_path=$compname/ ; done
