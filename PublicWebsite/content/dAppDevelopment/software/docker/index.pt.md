---
title: "Docker"
date: 2018-04-26T16:12:15-04:00
weight: 1
draft: false
---

* [Obtendo a imagem do docker] ({{<ref "#GettingStarted">}}) 
* [Criar uma rede docker] ({{<ref "#Network">}}) 
* [Executar os containers] ({{<ref "#Running">}}) 
* [Testando para verificar se está tudo funcionando] ({{<ref "#Testing">}}) 


{{% notice warning %}}
Observe que o [EOS Wiki] (https://github.com/EOSIO/eos/wiki/Local-Environment#3-docker) tem instruções sobre como usar um container docker para compilar o código da versão mais recente. Isso pode ter seus próprios problemas, então incentivamos o uso da imagem do docker mencionada abaixo enquanto você está aprendendo. Isso será mais fácil e rápido inicialmente. 
{{% /notice %}}


#### Introdução

Se você ainda não tem o docker instalado, você pode baixá-lo aqui: https://www.docker.com/community-edition

### 1. Obtendo a imagem do docker {#GettingStarted}

O comando abaixo irá baixar uma imagem do Ubuntu que contém o software compilado. 

```
docker pull eosio/eos
```

Como um teste rápido, execute a imagem e obtenha acesso a um shell bash, faça o seguinte: 

```
docker run --rm -it eosio/eos bash
```

Se isso funcionar, você deve obter um prompt parecido com o seguinte, e digitar "cleos" deve retornar a ajuda para a ferramenta cleos:

```
root@a5f9eafaab74:/#cleos
ERROR: RequiredError: Subcommand required
Command Line Interface to EOSIO Client
Usage: cleos [OPTIONS] SUBCOMMAND

Options:
  -h,--help                   Print this help message and exit
  -u,--url TEXT=http://localhost:8888/
                              the http/https URL where nodeos is running
  --wallet-url TEXT=http://localhost:8888/
                              the http/https URL where keosd is running
  -v,--verbose                output verbose actions on error

Subcommands:
  version                     Retrieve version information
  create                      Create various items, on and off the blockchain
  get                         Retrieve various items and information from the blockchain
  set                         Set or update blockchain state
  transfer                    Transfer EOS from account to account
  net                         Interact with local p2p network connections
  wallet                      Interact with local wallet
  sign                        Sign a transaction
  push                        Push arbitrary transactions to the blockchain
  multisig                    Multisig contract commands
  system                      Send eosio.system contract action to the blockchain.
root@a5f9eafaab74:/#
root@a5f9eafaab74:/#exit
```

saia da imagem digitando "exit"

#### 2. Crie uma rede docker {#Network}

Crie uma rede docker que permita que os containers se comuniquem entre si

```
docker network create eosnetwork
```


### 3. Execute os containers {#Running}

Para executar o software do servidor (na porta 7777): 

```
docker run --name server --network=eosnetwork --rm -p 7777:7777 -i eosio/eos /bin/bash -c "nodeos -e -p eosio --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin --plugin eosio::http_plugin -d /mnt/dev/data --http-server-address=0.0.0.0:7777 --access-control-allow-origin=*"
```

Para executar o software da carteira (na porta 5555): 

```
docker run --name wallet --network=eosnetwork --rm -p 5555:5555 -i eosio/eos /bin/bash -c "keosd --http-server-address=0.0.0.0:5555"
```

Vamos abrir um shell bash para que possamos testar algumas das ferramentas

```
docker run --name tools --network=eosnetwork --rm -it eosio/eos /bin/bash 
```

#### 4. Testando para verificar se tudo está funcionando {#Testing}

Agora vamos nos certificar de que o servidor está funcionando:

1. [http://localhost:7777/v1/chain/get_info](http://localhost:7777/v1/chain/get_info) deve funcionar em um navegador da web local
2. Executar este comando a partir da instância de ferramentas docker deve funcionar:

```
$ cleos -u http://server:7777 get info

# Resposta Esperada
{
  "server_version": "749a6759",
  "head_block_num": 1953,
  "last_irreversible_block_num": 1952,
  "last_irreversible_block_id": "000007a0c1ae4e28480dcbeef36e9d4970987969f850453dcf8e244b569d6325",
  "head_block_id": "000007a1fc0d5b3dd16ebfe18ab9a288ac8bc7d03caee050a58a502577d25560",
  "head_block_time": "2018-05-16T02:04:08",
  "head_block_producer": "eosio",
  "virtual_block_cpu_limit": 701979,
  "virtual_block_net_limit": 7389096,
  "block_cpu_limit": 99900,
  "block_net_limit": 1048576
}
```

```
$ cleos --wallet-url http://wallet:5555 wallet list keys

# Nós não criamos nenhuma carteira ainda, então esta é a resposta esperada
Wallets:
[]
[]
```



