---
title: "Arbitragem"
date: 2018-07-14T09:07:37-04:00
pre: "<b>4. </b>"
draft: false
weight: 5
---

No caso de uma ordem de Arbitragem, o seguinte processo deve ser seguido: 

## Notificação 

No momento da escrita (2018-07-14), o ECAF faz duas coisas:
1. Envie uma mensagem on chain 
2. Notifica os BPs enviando uma mensagem no canal Keybase #arbitration (por vezes, um aviso será publicado em #general dizendo às pessoas para verificar #arbitration).

Exemplo de mensagem no canal #arbitration:
```
==========================
Following is AN ACTIVE Order.

BP Actions Requested
=========================
DATE: 2018-07-13
SUMMARY: Temporary Freeze Order
DETAILS: An Arbitral Order AO-003 has been issued on the EOS MainNet. The transaction ID of the EOS message, issued from ECAF's official EOS account, and showing the location of the file and its hash is:
​
https://eosflare.io/tx/280bd6b813e60bb23ec9f7521c09b754a64b0d5ac4a5bac3fa84233be3c6a41c
​
Block Producers are requested to verify the file and take the appropriate actions.
​
Moti Tabulo, as ECAF Interim Administrator
```

O link é para transação (Exemplo: https://eosflare.io/tx/280bd6b813e60bb23ec9f7521c09b754a64b0d5ac4a5bac3fa84233be3c6a41c) que se parece com o seguinte:

```

{"msg":"This is NOT A TEST. https://eoscorearbitration.io/wp-content/uploads/2018/07/ECAF-Temporary-Freeze-Order-2018-07-13-AO-003.pdf (SHA3-256 hash: ca104c57af040b5b46ab6fb2bcb8455ed8f81402e5e586d8a50a47cfc2683a20)"}
```

## Verifique a origem da mensagem

A mensagem deveria ter sido enviada de / assinada por "ecafofficial". Então, olhando para as transações de conta "ecafofficial" deve mostrar a mesma mensagem:  

https://www.bloks.io/account/ecafofficial   

Ou você pode usar o cleos para fazer a mesma coisa:

```
cleos -u https://api.eosnewyork.io get actions ecafofficial --full
#  seq  when                              contract::action => receiver      trx id...   args
================================================================================================================
#    0   2018-06-27T00:05:16.500         eosio::updateauth => eosio         70b510b8...
{"account":"ecafofficial","permission":"active","parent":"owner","auth":{"threshold":1,"keys":[{"key":"EOS8P6dTuxPUWyvXoe9Tn1QG5QocxL8vMLoCq4J42p2KuX3e2g2vs","weight":1}],"accounts":[],"waits":[]}}
#    1   2018-06-27T00:05:41.500         eosio::updateauth => eosio         99ca1046...
{"account":"ecafofficial","permission":"owner","parent":"","auth":{"threshold":1,"keys":[{"key":"EOS8P6dTuxPUWyvXoe9Tn1QG5QocxL8vMLoCq4J42p2KuX3e2g2vs","weight":1}],"accounts":[],"waits":[]}}
#    2   2018-07-12T19:57:12.000         eosio::updateauth => eosio         e0f131e0...
{"account":"ecafofficial","permission":"active","parent":"owner","auth":{"threshold":1,"keys":[{"key":"EOS4v8eF1V6huuYrBvubWsQumS1TkF2SqzkLsAv9i3LkPLXd6V2rs","weight":1}],"accounts":[],"waits":[]}}
#    3   2018-07-13T18:12:16.500       decentwitter::tweet => decentwitter  1f45361f...
{"msg":"TEST! https://eoscorearbitration.io/wp-content/uploads/2018/07/ECAF_Arbitrator_Order_2018-06-19-AO-001.pdf (SHA3-256 hash: a80df3e8cfa895a02161dc4d5d04392e3274bce917935c6c214cfe0f1f7e868a)"}
#    4   2018-07-13T21:49:31.000       decentwitter::tweet => decentwitter  280bd6b8...
{"msg":"This is NOT A TEST. https://eoscorearbitration.io/wp-content/uploads/2018/07/ECAF-Temporary-Freeze-Order-2018-07-13-AO-003.pdf (SHA3-256 hash: ca104c57af040b5b46ab6fb2bcb8455ed8f81402e5e586d8a50a47cfc2683a20)"}
```


### Verifique se o hash do arquivo corresponde 

A mensagem na cadeia deve conter um hash SHA3-256 - neste exemplo: ca104c57af040b5b46ab6fb2bcb8455ed8f81402e5e586d8a50a47cfc2683a20

Baixe o arquivo e verifique o hash

```
$apt install rhash

$wget https://eoscorearbitration.io/wp-content/uploads/2018/07/ECAF-Temporary-Freeze-Order-2018-07-13-AO-003.pdf

rhash --sha3-256 ECAF-Temporary-Freeze-Order-2018-07-13-AO-003.pdf

ca104c57af040b5b46ab6fb2bcb8455ed8f81402e5e586d8a50a47cfc2683a20  ECAF-Temporary-Freeze-Order-2018-07-13-AO-003.pdf
```

## Aplique a mudança ao seu(s) nó(s) de BP

No exemplo de pedido do ECAF, as seguintes contas foram listadas, então vamos adicioná-las como entradas ao arquivo de configuração. 

```
neverlandwal
tseol5n52kmo
potus1111111
```

O arquivo de configuração do BP deve conter vários registros com a seguinte aparência: 

```
actor-blacklist = blacklistmee
actor-blacklist = ge2dmmrqgene
actor-blacklist = gu2timbsguge
actor-blacklist = ge4tsmzvgege
actor-blacklist = gezdonzygage
...
...
...
actor-blacklist = gu2teobyg4ge
actor-blacklist = gu4damztgyge
actor-blacklist = ha4doojzgyge
actor-blacklist = neverlandwal
actor-blacklist = tseol5n52kmo
actor-blacklist = potus1111111
```

Para confirmar que você não fez nenhum erro de digitação, execute o seguinte comando e compartilhe a saída no canal # arbitragem. 

```
$grep actor-black config.ini | grep -v "#" | sort | tr -d " " | sha256sum
d2acb47d52615e316f89b04d397852daae4137bd0355768c8876783885d6cbd6
```

Os outros BPs também estarão compartilhando seu hash e o seu deve corresponder a eles. 




#### Referências 

https://steemit.com/eos/@ecaf/draft-proposal-for-ecaf-s-official-notification-system
