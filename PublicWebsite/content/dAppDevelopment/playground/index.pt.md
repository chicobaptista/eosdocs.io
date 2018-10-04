---
title: "Playground"
date: 2018-04-30T15:53:46-04:00
draft: false
weight: 15
---

{{<EOS_Create_Account>}}


{{%expand "Como você pode fazer a mesma coisa na linha de comando?" %}}
#### Criação de conta

A criação de contas é tratada em detalhes [aqui] (../ contas). Mas, em resumo, tudo o que esta página está fazendo é:

* 1. Gerando um par de chaves a ser usado para o owner. 
* 2. Gerando um par de chaves a ser usado para o active.
* 3. Criando a conta usando as chaves públicas de cada uma das opções acima. 

```
$ ./cleos create key
Private key: AAAAAAAAAAAA
Public key: CCCCCCCCCC


$./cleos create key
Private key: CCCCCCCCC
Public key: DDDDDDDDDDDD

$./cleos -H {Server} -p {Port} create account eosio mynewaccount CCCCCCCCCC DDDDDDDDDDDD
```

{{% /expand%}}

{{%expand "Como você pode adicionar um contrato à sua nova conta?" %}}

#### Compilador de contrato baseado na Web

A criação de contratos é abordada em detalhes [aqui] (../ smartcontractbasics). Mas se você quiser testar um contrato sem instalar todos os compiladores e ferramentas, você pode usar um editor de contrato baseado na web: 


Depois de criar uma conta usando a ferramenta acima. Você pode então usar <a href="https://tbfleming.github.io/cib/eos-dawn4.html" target="_blank"> ESTA</a><br> ferramenta para compilar um contrato e adicioná-lo a sua nova conta. 

Aqui estão alguns exemplos de contrato: <br>
Exemplo 1: <a href="https://tbfleming.github.io/cib/eos-dawn4.html#gist=8b2b9a60cf51afcfaeb80e88c74d66ae" target="_blank"> Clique aqui</a> <br> 
{{% /expand%}}

<hr>

{{< eosserver >}}