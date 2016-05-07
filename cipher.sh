#!/bin/bash

function genFiles {
	echo "En un lugar de la Mancha, de cuyo nombre no quiero acordarme, no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero, adarga antigua, rocín flaco y galgo corredor. Una olla de algo más vaca que carnero, salpicón las más noches, duelos y quebrantos los sábados, lantejas los viernes, algún palomino de añadidura los domingos, consumían las tres partes de su hacienda. El resto della concluían sayo de velarte, calzas de velludo para las fiestas, con sus pantuflos de lo mesmo, y los días de entresemana se honraba con su vellorí de lo más fino. Tenía en su casa una ama que pasaba de los cuarenta, y una sobrina que no llegaba a los veinte, y un mozo de campo y plaza, que así ensillaba el rocín como tomaba la podadera. Frisaba la edad de nuestro hidalgo con los cincuenta años; era de complexión recia, seco de carnes, enjuto de rostro, gran madrugador y amigo de la caza. Quieren decir que tenía el sobrenombre de Quijada, o Quesada, que en esto hay alguna diferencia en los autores que deste caso escriben; aunque, por conjeturas verosímiles, se deja entender que se llamaba Quejana. Pero esto importa poco a nuestro cuento; basta que en la narración dél no se salga un punto de la verdad." > doc.txt
	xxd -b doc.txt > doc.bin
}

function encryptText {
	openssl enc -aes-256-cbc -in doc.txt -out ./enc/doc.aes256.txt
	openssl enc -camellia-256-cfb8 -in doc.txt -out ./enc/doc.camellia.txt
	openssl enc -des-cbc -in doc.txt -out ./enc/doc.des.txt
	openssl enc -idea-cbc -in doc.txt -out ./enc/doc.idea.txt
	openssl enc -cast5-cbc -in doc.txt -out ./enc/doc.cast5.txt
}

function encryptBinary {
	openssl enc -aes-256-cbc -in doc.bin -out ./enc/doc.aes256.bin
        openssl enc -camellia-256-cfb8 -in doc.bin -out ./enc/doc.camellia.bin
        openssl enc -des-cbc -in doc.bin -out ./enc/doc.des.bin
        openssl enc -idea-cbc -in doc.bin -out ./enc/doc.idea.bin
        openssl enc -cast5-cbc -in doc.bin -out ./enc/doc.cast5.bin	
}

function decryptText {
	openssl enc -d -aes-256-cbc -in ./enc/doc.aes256.txt -out doc.txt
        openssl enc -d -camellia-256-cfb8 -in ./enc/doc.camellia.txt -out doc.txt
        openssl enc -d -des-cbc -in ./enc/doc.des.txt -out doc.txt
        openssl enc -d -idea-cbc -in ./enc/doc.idea.txt -out doc.tx -out doc.txt
        openssl enc -d -cast5-cbc -in ./enc/doc.cast5.txt -out doc.txt
}

function decryptBinary {
        openssl enc -d -aes-256-cbc -in ./enc/doc.aes256.bin -out doc.bin
        openssl enc -d -camellia-256-cfb8 -in ./enc/doc.camellia.bin -out doc.bin
        openssl enc -d -des-cbc -in ./enc/doc.des.bin -out doc.bin
        openssl enc -d -idea-cbc -in ./enc/doc.idea.bin -out doc.bin
        openssl enc -d -cast5-cbc -in ./enc/doc.cast5.bin -out doc.bin
}


if [ -z "$1" ]
then
	genFiles
	encryptText
	encryptBinary
	decryptText
	decryptBinary
	exit 0
fi

case $1 in
	1)
		genFiles
		;;
	2)
		encryptText
		;;
	3)
		decryptText
		;;
	4)
		encryptBinary
		;;
	5)
		decryptBinary
		;;
	6)
		encryptText
		encryptBinary
		;;
	7)
		decryptText
		decryptBinary
		;;
	*)
		echo "Wrong option."
		exit 1
esac

exit 0
