rule "terraform_typed_variables" {
  enabled = true
}

# Retained compatibility declarations are tracked separately from lint tooling.
rule "terraform_unused_declarations" {
  enabled = false
}
