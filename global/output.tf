output "private_key_contents" {
  value = base64decode(data.oci_secrets_secretbundle.private_key.secret_bundle_content[0].content)
}