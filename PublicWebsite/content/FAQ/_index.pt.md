---
title: "Perguntas frequentes"
date: 2018-06-11T09:07:37-04:00
pre: "<b>4. </b>"
draft: false
weight: 6
---

#### Criar Conta
```
# substituir <valores> por seus próprios valores
# adicionar chaves à carteira
cleos --wallet-url <wallet url> --url <api endpoint url> wallet import <priv key>

# criar conta
# a quantia em stake deve se parecer com "1.0025 EOS" e requer 4 números após a casa decimal
cleos --wallet-url <wallet url> --url <api endpoint url> system newaccount <creator account> <created account> <owner public key> <active public key> --stake-net "N.NNNN EOS" --stake-cpu "N.NNNN EOS" --buy-ram-kbytes 8 --transfer
```

#### Definir chave Active

```
# substituir <valores> por seus próprios valores
cleos --wallet-url <wallet url> --url <api endpoint url> set account permission <account name> active <public key> owner
```

#### Definir chave Owner

```
# substituir <valores> por seus próprios valores
cleos --wallet-url <wallet url> --url <api endpoint url> set account permission <account name> owner <public key> -p <account name>@owner
```

#### Votar em Producers

```
# substituir <valores> por seus próprios valores
# voto para múltiplos produtores
cleos --wallet-url <wallet url> --url <api endpoint url> system voteproducer prods <account name> <producer 1> <producer 2>

# anexar voto ao produtor
cleos --wallet-url <wallet url> --url <api endpoint url> system voteproducer approve <account name> <producer>
```