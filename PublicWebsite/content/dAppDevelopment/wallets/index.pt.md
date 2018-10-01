---
title: "Carteiras"
date: 2018-04-25T10:31:55-04:00
weight: 3
draft: false
---

* [Iniciar o processo do keosd em background] ({{<ref "#keosd">}})
* [Criar uma carteira] ({{<ref "#create">}})
* [Carteiras precisam ser abertas] ({{<ref "#open">}})
* [Desbloqueando sua carteira] ({{<ref "#unlock">}})
* [Adicionando chaves] ({{<ref "#AddingKeys">}})
* [Trabalhando com várias carteiras] ({{<ref "#MultipleWallets">}})




### Introdução

Atualmente, existem duas opções de carteira disponíveis:

* Um plugin que você pode iniciar com o servidor nodeos.
* Um daemon independente que pode ser executado em um servidor separado, independente do servidor nodeos. ** << Vamos usar esta opção **

> ** NÃO FORNEÇA O SEGUINTE AO INICIAR O SERVIDOR NODEOS: ** --plugin eosio:: wallet_api_plugin

### Conceitos importantes

Muitas pessoas envolvidas em Crypto pensam em uma carteira como algo que armazena "Tokens". Esta não é a maneira correta de se pensar sobre a carteira.

![Moedas não são armazenadas na carteira] (images/NoCoins.png)

A carteira é apenas um lugar onde os pares de chaves são armazenados.

A imagem abaixo ilustra que o daemon keosd pode ter múltiplas carteiras e cada carteira pode conter vários pares de chaves públicas + privadas

![Moedas não são armazenadas na carteira] (images/keosd.png)

### 1. Inicie o processo do keosd no background {#keosd}

A carteira que vamos discutir é um daemon chamado keosd

Para executar o daemon da carteira, basta iniciar o executável. Observe que, se você estiver usando imagens do docker e estiver seguindo as [instruções do docker] (../software/docker/#Running), já terá um contêiner do Docker executando o daemon de carteira. 

```
cd eos/build/programs/keosd/
./keosd
```

{{% notice warning %}}
Por padrão, o keosd é executado na porta 8888. Esta é a mesma porta que o aplicativo nodeos usa por padrão, portanto, se você estiver executando isso na mesma máquina, precisará fornecer algo assim para ser executado na porta 8899 "./keosd --http-server-address=localhost:8899"
{{% /notice %}}

Se você está executando o servidor pela primeira vez, você precisa gerar automaticamente um arquivo INI na pasta padrão "config" ~/eosio-wallet/config.ini

### 2. Criar uma carteira {#create}

Vamos criar uma carteira padrão: 

```
$cleos --wallet-url http://wallet:5555 wallet create

Creating wallet: default
Save password to use in the future to unlock this wallet.
Without password imported keys will not be retrievable.
"PW5Kewn9L76X8Fpd....................t42S9XCw2"
```

{{% notice tip %}}
Salve esta senha em algum lugar seguro e rotule-a como: SENHA DA WALLET PADRÃO 
{{% /notice %}}

Por padrão, as carteiras são armazenadas em ~/eosio-wallet/default.wallet. Se você estiver seguindo as instruções do docker e quiser fazer o SSH no contêiner docker da carteira para explorar o sistema de arquivos e ver esse arquivo, poderá executar o seguinte em um novo prompt de comando: "docker exec -it wallet bash"

{{% notice note %}}
Note que a chave mestra EOS foi adicionada a esta carteira para você. Não fique confuso com isso, tudo que você fez até agora é criar uma carteira - e agora você tem uma senha para desbloquear essa carteira. 
{{% /notice %}}

Vamos dar uma olhada no que está na carteira.

```
$cleos --wallet-url http://wallet:5555 wallet keys
[[
    "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
    "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
  ]
]
```

Como você pode ver, há um par de chaves em sua carteira recém-criada. Este é o par de chaves mestre para a única conta inicial, ** eosio **

** Não confunda a chave mestra acima com as chaves que você adicionará no futuro **

### 3. Carteiras precisam ser abertas {#open}

Algo que pode ser um pouco confuso é que as carteiras que não estão "abertas" não são listadas quando se usa o comando "list". Aqui está um exemplo:

Vamos começar matando e reiniciando o processo keosd.
```
$ pkill keosd
$ ./keosd
```
Agora podemos ver que usar o comando list não retorna nada ... para onde minha carteira foi?

```
$cleos --wallet-url http://wallet:5555 wallet list

Wallets:
[]
```

O problema é que a carteira precisa ser "aberta" antes de aparecer na sua lista de carteiras (algo que pode ser melhorado na minha opinião)

```
$cleos --wallet-url http://wallet:5555 wallet open

$cleos --wallet-url http://wallet:5555 wallet list

Wallets:
[
  "default"
]
```


### 4. Desbloqueando sua carteira {#unlock}

Simplesmente ter sua carteira aberta não adianta muito, agora você precisa DESBLOQUEAR a carteira.

```
$cleos --wallet-url http://wallet:5555 wallet unlock

#{Você precisará fornecer sua senha aqui}
password: Unlocked: default
```

Note como quando eu listo a carteira agora, há um * ao lado do nome, indicando que ele foi desbloqueado.
```
$cleos --wallet-url http://wallet:5555 wallet list
Wallets:
[
  "default *"
]
```

{{% notice note %}}
Note que quando você criou sua carteira usando o "./cleos wallet create" na etapa 2 acima, sua carteira foi deixada em um estado Aberto e Desbloqueado. O que tende a acontecer é que as coisas funcionam enquanto você está seguindo um tutorial, mas não funcionam depois de uma reinicialização. Se você não entender essa necessidade de abrir e desbloquear a carteira antes que ela possa ser usada, você ficará confuso em algum momento.
{{% /notice %}}


### 5. Adicionando chaves {#AddingKeys}

Conforme detalhado na seção [Contas] (../ accounts /), cada conta tem duas permissões, o ** owner ** e o ** active **.

Portanto, na maioria dos casos, você desejará criar duas chaves para poder associar uma chave a cada permissão (mais sobre isso posteriormente).

O comando "create key" abaixo apenas imprime um par de chaves para a tela. Não é armazenado, portanto, você precisará importar essas chaves para uma carteira.

```
$cleos create key
Private key: 5JKrSzsuztAPvTzghi9VU4522sT49SeE3XVHbB8HsfC3ikifJRf
Public key: EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF


$cleos create key
Private key: 5KgcXVKU7Lfs2iFpAP1Aqiz3SEZcmbLuh6y9Lvsi4bYcFwDUVBQ
Public key: EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN
```

Agora vamos importar as chaves para nossa carteira.

```
$cleos --wallet-url http://wallet:5555 wallet import 5JKrSzsuztAPvTzghi9VU4522sT49SeE3XVHbB8HsfC3ikifJRf
imported private key for: EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF


$cleos --wallet-url http://wallet:5555 wallet import 5KgcXVKU7Lfs2iFpAP1Aqiz3SEZcmbLuh6y9Lvsi4bYcFwDUVBQ
imported private key for: EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN
```

Se olharmos para a nossa carteira agora, podemos ver 3 chaves públicas. A única chave mestra que foi adicionada quando criamos a carteira e as duas chaves que acabamos de importar. 

```
./cleos --wallet-url http://wallet:5555 wallet keys
[
    "EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN",
    "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
    "EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF"
]
```

Podemos realizar um query pelos pares de chaves também, essa solicitação solicitará a senha da carteira.

```
./cleos --wallet-url http://wallet:5555 wallet private_keys
password:
[[
    "EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN",
    "5KgcXVKU7Lfs2iFpAP1Aqiz3SEZcmbLuh6y9Lvsi4bYcFwDUVBQ"
  ],[
    "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
    "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
  ],[
    "EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF"
    "5JKrSzsuztAPvTzghi9VU4522sT49SeE3XVHbB8HsfC3ikifJRf"
  ]
]
```

{{% notice warning %}}
Como dissemos acima, é importante saber qual a chave que você planeja usar para qual finalidade. Quando você armazenar suas chaves, identifique claramente as chaves conforme o exemplo abaixo
{{% /notice %}}

** Ao rotular nossas novas chaves da seguinte forma, você terá muito menos probabilidade de misturar as chaves à medida que desenvolver.**

```

    eosio Public Key: "EOS5tJQSKKeiTUZEutPo9SWUoCeovV43kWxGuW21K663frcHw7GnN",
    eosio Private Key: "5KgcXVKU7Lfs2iFpAP1Aqiz3SEZcmbLuh6y9Lvsi4bYcFwDUVBQ"

    MyNewAccount owner Public Key: "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
    MyNewAccount owner Private Key: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"

    MyNewAccount active Public Key: "EOS7EzCEh94uN2k59wznzsZDcFVnpZ3wuiYvPSbb8bXDS6U7twKQF",
    MyNewAccount active Private Key: "5JKrSzsuztAPvTzghi9VU4522sT49SeE3XVHbB8HsfC3ikifJRf"
```

### 6. Trabalhando com várias carteiras {#MultipleWallets}

O daemon keosd permite que você tenha várias carteiras.

Embora não seja abordado em detalhes aqui, a maioria dos comandos acima usa parâmetros que permitem especificar o nome da carteira com a qual você deseja interagir. Exemplo:

```
$cleos --wallet-url http://wallet:5555 wallet create -n MyTestWallet
$cleos --wallet-url http://wallet:5555 wallet import 5KgcXVKU7Lfs2iFpAP1Aqiz3SEZcmbLuh6y9Lvsi4bYcxxxxxxxx -n MyTestWallet
```

https://github.com/EOSIO/eos/wiki/Tutorial-Getting-Started-With-Contracts


##### Créditos
A imagem da carteira e chaves foram usadas sob licença livre da freepic
<a href="https://www.freepik.com/free-vector/flat-key-background_1637044.htm">Image 1</a>
<a href='https://www.freepik.com/free-vector/dollar-coins_759113.htm'>Image 2</a>

Muitas dessas informações também podem ser encontradas aqui: https://github.com/EOSIO/eos/wiki/Tutorial-Getting-Started-With-Contracts
