#!/bin/bash

function dgst {
	openssl dgst -md5 doc.txt > ./dgst/doc.md5.txt
	openssl dgst -sha256 doc.txt > ./dgst/doc.sha256.txt
	openssl dgst -whirlpool doc.txt > ./dgst/doc.whirlpool.txt
	openssl dgst -sha512 doc.txt > ./dgst/doc.sha512.txt
}

function keysGen {
	openssl genrsa -des3 -out ./keys/private.key 2048
	openssl rsa -in ./keys/private.key -out ./keys/public.key -pubout
}

function pemToDer {
	openssl rsa -inform PEM -outform DER -in ./keys/private.key \
		-out ./keys/private.key.der
	openssl rsa -inform PEM -outform DER -in ./keys/private.key \
		-out ./keys/public.key.der -pubout
}

function derToPem {
	openssl rsa -inform DER -outform PEM -in ./keys/private.key.der \
		-out ./keys/private.key
        openssl rsa -inform DER -outform PEM -in ./keys/private.key.der \
		-out ./keys/public.key -pubout
}

function signAndVerify {
	openssl dgst -sha256 -sign ./keys/private.key \
		-out ./dgst/doc.sign.txt doc.txt
	openssl dgst -sha256 -verify ./keys/public.key \
		-signature ./dgst/doc.sign.txt doc.txt
}

if [ -z "$1" ]
then
	dgst
	keysGen
	pemToDer
	signAndVerify
	exit 0
fi

case $1 in
	1)
		dgst
		;;
	2)
		keysGen
		;;
	3)
		pemToDer
		;;
	4)
		derToPem
		;;
	5)
		signAndVerify
		;;
	*)
		echo "Wrong option."
		exit 1
esac

exit 0
