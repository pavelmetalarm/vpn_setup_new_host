#!/bin/bash


easyrsa=/usr/share/easy-rsa/easyrsa
pki_path=/root/easy-rsa/pki/
keys_storage_path=/root/client-configs/keys
make_config=/root/client-configs/make_config.sh
issued_certs=/root/easy-rsa/pki/issued/
ovpn_configs=/home/paul/ovpn_configs/
export EASYRSA_PKI=/root/easy-rsa/pki

#/root/client-configs

client_name=$1


echo "gen-req"
easyrsa gen-req $client_name nopass &&

echo "cp key to keystorage $keys_storage_path"
cp $pki_path/private/$client_name.key $keys_storage_path &&


echo "import req"
easyrsa import-req  /root/easy-rsa/pki/reqs/$client_name.req $client_name &&


echo "signing req.."
easyrsa sign-req client $client_name &&



echo "move cert to $keys_storage_path.."
mv $issued_certs$client_name.crt $keys_storage_path &&

echo "generate $client_name.ovpn config.." &&
$make_config $client_name

echo "chown access"
mv /root/client-configs/files/$client_name.ovpn $ovpn_configs &&
chown paul:paul $ovpn_configs$client_name.ovpn

