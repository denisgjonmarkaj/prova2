export AWS_ACCESS_KEY_ID=$(oci secrets secret-bundle get --secret-id "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaarhmdlkaat26e6tfobamrzxdila5qy54sgxrq4ustsdltj4ygo7qq" --query "data.\"secret-bundle-content\".content" --raw-output --profile BMW-TF | base64 --decode)
if [ $? -eq 0 ];then
 echo "Key AWS_ACCESS_KEY_ID esportata"
else
 echo "Key AWS_ACCESS_KEY_ID NON esportata"
fi 



sleep 1

export AWS_SECRET_ACCESS_KEY=$(oci secrets secret-bundle get --secret-id "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaarhmdlkaaoar4iyl57uhwyxffxhkpt6kquauygjzgqcpqiraxtgsq" --query "data.\"secret-bundle-content\".content" --raw-output --profile BMW-TF | base64 --decode)
if [ $? -eq 0 ];then
 echo "Key AWS_SECRET_ACCESS_KEY esportata"
else
 echo "Key AWS_SECRET_ACCESS_KEY NON esportata"
fi 

