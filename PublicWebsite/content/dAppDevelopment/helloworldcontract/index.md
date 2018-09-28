---
title: "Hello world contract"
date: 2018-04-24T09:23:39-04:00
weight: 5
draft: false
---

### 1. Criando seu primeiro contrato

https://github.com/EOSIO/eos/wiki/Tutorial-Getting-Started-With-Contracts

-p eosio informa ao cleos para assinar esta ação com a autoridade **active** da conta eosio, ou seja, para assinar a ação usando a chave privada da conta eosio que importamos anteriormente.

```
# Se você estiver usando a imagem do docker, você encontrará o código-fonte para os contratos de exemplo. Nós vamos adicionar outro aqui. 
$cd /eos/contracts/hello

```

No diretório hello, crie um novo arquivo "hello.cpp" com o seguinte conteúdo

```
$vi hello/hello.cpp
```

```
#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
using namespace eosio;

class hello : public eosio::contract {
 public:
     using contract::contract;

     /// @abi action
     void hi( account_name user ) {
             print( "Hello, ", name{user} );
     }
};

EOSIO_ABI( hello, (hi) )

```

Agora vamos compilar o C ++ em web assembly (arquivo .wast)

```
$eosiocpp -o /eos/contracts/hello/hello.wast /eos/contracts/hello/hello.cpp

# A saída será algo como...
In file included from /eos/contracts/hello/hello.cpp:5:
In file included from /eos/contracts/hello/hello.hpp:5:
In file included from /usr/local/include/eosiolib/eosio.hpp:7:
In file included from /usr/local/include/eosiolib/action.hpp:7:
In file included from /usr/local/include/eosiolib/datastream.hpp:9:
....
....
5 warnings generated.  


# Você pode ignorar esses avisos

```

Gerar um arquivo abi

```
eosiocpp -g /eos/contracts/hello/hello.abi /eos/contracts/hello/hello.cpp
```

Confirme, você deve ter agora um arquivo .wast e um arquivo .abi na pasta. 

```
$ls -1 /eos/contracts/hello/

hello.abi
hello.cpp
hello.wast
```


### 2. Carregar seu novo contrato para sua conta

```
$cleos --wallet-url http://wallet:5555 -u http://server:7777 set contract mynewaccount /eos/contracts/hello/ -p mynewaccount

Reading WAST/WASM from /eos/contracts/hello/hello.wast...
Assembling WASM...
Publishing contract...
executed transaction: c15e40773b43e98022022c808ee013c0acd5c758ff3ebab5f9e64e98d2c07540  1648 bytes  2200576 cycles
#         eosio <= eosio::setcode               {"account":"mynewaccount","vmtype":0,"vmversion":0,"code":"0061736d0100000001370b60027f7e0060027e7e0...
#         eosio <= eosio::setabi                {"account":"mynewaccount","abi":{"types":[],"structs":[{"name":"hi","base":"","fields":[{"name":"use...
```

```
$cleos --wallet-url http://wallet:5555 -u http://server:7777 push action mynewaccount hi '["username1"]' --permission mynewaccount@active

executed transaction: 259f32454f3b075cc0eb02557e858da9dcce39d88b833bda62a0ac51ba5e340c  232 bytes  102400 cycles
#  mynewaccount <= mynewaccount::hi             {"user":"username1"}
>> Hello, username1
```

