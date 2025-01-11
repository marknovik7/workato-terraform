output key_name {
    value = aws_key_pair.generated_key.key_name
}

output public_key {
    value = aws_key_pair.generated_key.public_key
}

