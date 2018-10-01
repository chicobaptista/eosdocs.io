---
title: "Contas"
date: 2018-04-25T16:07:09-04:00
weight: 4
draft: false
---

### 1. Criando uma nova conta {#create}

Contas precisam ser criadas por outra conta. 

Supondo que você tenha seguido as instruções na seção [Carteiras] (../wallets/), agora você deve ter uma carteira em um estado desbloqueado que contenha 3 pares de chaves. 

<font color="red">Verifique se você está usando as chaves públicas que você gerou, não as duas mostradas abaixo</ font>
```
$cleos --wallet-url http://wallet:5555 -u http://server:7777 create account eosio mynewaccount {MyNewAccount owner Public Key} {MyNewAccount active Public Key}

$cleos --wallet-url http://wallet:5555 -u http://server:7777 create account eosio mynewaccount EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN
```

A resposta deve ser algo como isto
```
executed transaction: d4a764ae9c728f9a2c95537613445f059e4833d1cde12504f6d6e88ec10951ab  352 bytes  102400 cycles
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"mynewaccount","owner":{"threshold":1,"keys":[{"key":"EOS6MRyAjQq8ud7hVNYc...
```

{{% notice note %}}
Observe que os nomes das contas devem estar em letras minúsculas e devem ter menos de 13 caracteres. (Contém apenas os seguintes símbolos.12345abcdefghijklmnopqrstuvwxyz). Observe que 6,7,8,9,0 não são permitidos. 
{{% /notice %}}

### 2. Informações da conta {#info}

```
$cleos -u http://server:7777 get account mynewaccount -j

{
  "account_name": "mynewaccount",
  "permissions": [{
      "perm_name": "active",
      "parent": "owner",
      "required_auth": {
        "threshold": 1,
        "keys": [{
            "key": "EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN",
            "weight": 1
          }
        ],
        "accounts": []
      }
    },{
      "perm_name": "owner",
      "parent": "",
      "required_auth": {
        "threshold": 1,
        "keys": [{
            "key": "EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF",
            "weight": 1
          }
        ],
        "accounts": []
      }
    }
  ]
}

```

Ou obtenha todas as contas vinculadas a uma determinada chave pública

```
$cleos  -u http://server:7777 get accounts EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF

{
  "account_names": [
    "mynewaccount",
    "test1"
  ]
}

```
