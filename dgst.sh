#!/bin/bash

openssl dgst -md5 doc.txt > /dgst/doc.txt.md5
openssl dgst -sha256 doc.txt > /dgst/doc.txt.sha256
openssl dgst -whirlpool doc.txt > /dgst/doc.txt.whirlpool
openssl dgst -sha512 doc.txt > /dgst/doc.txt.sha512

exit 0
