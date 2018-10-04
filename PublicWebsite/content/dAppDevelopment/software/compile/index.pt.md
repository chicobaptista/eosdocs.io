---
title: "Compilar"
date: 2018-04-26T16:17:47-04:00
weight: 3
draft: false
---


### Introdução

É possível compilar o software EOS em quase todas as plataformas. Vamos usar uma instância da AWS, pois a maioria das pessoas terá a capacidade de criar uma conta da AWS e acompanhar o processo.

A página oficial tem muito mais detalhes. Se você gostaria de compilá-lo em sua própria máquina, siga as instruções [AQUI](https://github.com/EOSIO/eos/wiki/Local-Environment#2-building-eosio)

#### Compilando o software EOS

{{% notice warning %}}
A compilação do software EOS leva cerca de 3 horas em uma instância do AWS t2.large.
{{% /notice %}}



```
sudo su
yum update
yum install git
```


```
sudo su
mkdir dev
cd dev/
git clone https://github.com/EOSIO/eos --recursive
cd eos/
./eosio_build.sh

```

Isto é o que você deve ver quando o processo for concluído cerca de três horas depois.
![Clique em [Next](images/Completed Compile.png)

```
cd build/
make install
```

```
cd build/programs/nodeos
./nodeos -e -p eosio --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin
```

Em outra janela de terminal, verifique se você pode obter as informações do servidor
```
curl http://127.0.0.1:8888/v1/chain/get_info
```

Na maioria dos casos, queremos ser capazes de nos conectar a esse URL remotamente. Por isso, precisaremos atualizar o arquivo.INI (arquivo de configuração)
{{% notice warning %}}
Se você não executou a instrução ./nodeos ... acima, a pasta abaixo ~ /.local ainda não existirá
{{% /notice %}}

```
# Para Linux
vi ~/.local/share/eosio/nodeos/config/config.ini
# Para Mac OS
vi ~/Library/Application Support/eosio/nodeos/config/config.ini

#Edite a seguinte linha:
http-server-address = 127.0.0.1:8888

#Para se parecer da seguinte maneira
http-server-address = 0.0.0.0:8888
```

Agora você pode ir para o servidor http://{URL do Seu Servidor}:8888/v1/chain/get_info

Exemplo:
http://ec2-35-171-26-29.compute-1.amazonaws.com:8888/v1/chain/get_info

A resposta será algum JSON que se pareça com isto:
```
{
  "head_block_id": "0000030958e04a60a886d7eaec578eb438980b6feaf7c65a65a1609bc2eacb97",
  "head_block_num": 777,
  "head_block_producer": "eosio",
  "head_block_time": "2018-04-25T02:05:51",
  "last_irreversible_block_num": 776,
  "server_version": "dead9cef"
}
```

A mesma coisa pode ser obtida usando a ferramenta cleos que pode ser encontrada na pasta eos/build/programs/cleos.

cleos -u ${nodeos_host}:${nodeos_port} get info
```
./cleos -u 127.0.0.1:8888 get info
```

