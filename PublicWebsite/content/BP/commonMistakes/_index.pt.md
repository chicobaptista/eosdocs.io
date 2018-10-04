---
title: "Erros comuns"
date: 2018-06-11T09:07:37-04:00
pre: "<b>3. </b>"
draft: false
weight: 4
---

## Memória de estado da chain insuficiente

{{% notice warning %}}
NÃO apenas copie e cole chain-state-db-size-mb = 65536 em seu arquivo de configuração, leia como o valor deve ser calculado para garantir que você esteja configurando o valor correto. O valor mudará com o tempo.
{{% /notice %}}

O eosio config.ini contém um parâmetro "chain-state-db-size-mb" que deve corresponder ao máximo de memória anunciado pela rede. 

```
# Tamanho máximo (em MB) do banco de dados de estado da chain (eosio::chain_plugin)
chain-state-db-size-mb = 65536
```

Esse valor deve sempre ser definido para a memória máxima anunciada pela rede. 

Como BP, você deve saber qual é a alocação de memória esperada, mas sempre confirme consultando os endpoints de BPs top pelas seguintes informações para confirmar:


```

$cleos -u http://api.eosnewyork.io get table eosio eosio global
{
  "rows": [{
...
      "max_ram_size": "68719476736",
...
    }
  ],
  "more": false
}

```
#### Conversão matemática:

Em seguida, execute as contas abaixo para converter em MB

68719476736 / 1024 / 1024 = __65536__ 

Então, no momento da escrita, chain-state-db-size-mb deve ser definido como __65536__