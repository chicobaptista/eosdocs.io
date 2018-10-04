---
título: "endpoints da API"
date: 2018-04-30T15:53:46-04:00
draft: false
weight: 1
---

### Endpoints da API pública Mainnet 
#### Chain_id: aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906

Cada block producer publica um arquivo bp.json que, entre outras coisas, lista seus endpoints da API (se eles escolheram fornecer um). As etapas são as seguintes: 

- encontre o URL público do produtor (veja http://eosnetworkmonitor.io/ ou https://eostracker.io/producers)
- acrescente `/ bp.json` a ele
- procure a chave `api_endpoint` - o valor correspondente é o endpoint da API. 
- por exemplo, para eosnewyork, você usaria: http://bp.eosnewyork.io/bp.json 

O que está dito abaixo é uma referência rápida a alguns terminais públicos da API que podem ser usados ​​para votar / interagir com o blockchain EOS de produção. 

* `https://api.eosnewyork.io`
* `https://api.eosio.cr:80`
* `https://api.eosdetroit.io:443`
* `https://eos.greymass.com:443`
* `https://api.eosmetal.io:18890`
* `http://api.hkeos.com:80`
* `https://eosapi.blockmatrix.network:443`
* `https://fn.eossweden.se:443`
* `http://api.blockgenicbp.com:8888`
* `http://mainnet.eoscalgary.io:80`
* `https://node1.eosphere.io` and `https://node2.eosphere.io`
* `https://eos.saltblock.io`
* `http://eos-api.worbli.io:80`
* `https://eos-api.worbli.io:443`
* `http://mainnet.eoscalgary.io:80`
* `https://user-api.eoseoul.io:443` e `http://user-api.eoseoul.io:80` com suporte a CORS
* `https://node2.liquideos.com:8883` e `http://node2.liquideos.com:8888`
* `https://api.eosuk.io:443`
* `http://api1.eosdublin.io:80`
* `http://api.eosvibes.io:80`
* `http://api.cypherglass.com:8888` e `https://api.cypherglass.com:443`
* `http://bp.cryptolions.io:8888`
* `http://dc1.eosemerge.io` e `https://dc1.eosemerge.io`
* `https://api.eosio.cr:443`
* `https://api.eosn.io`
* `https://eu1.eosdac.io:443`
* `https://api.main.alohaeos.com:443`
* `https://rpc.eosys.io`

#### Nota de Uso para usuários do cleos

Para testar rapidamente uma dessas apis execute: 

`cleos -u <url> get info`

por exemplo: 

`cleos -u http://api.eosnewyork.io:80 get info`

Você deve ver uma resposta com as informações de bloco mais recentes, o nome do produtor, o registro de data e hora, etc. 

Por favor, note que para realizar a votação você precisará interagir com o subcomando `system` no endpoint que você está acessando. Alguns dos pontos de extremidade acima podem estar sendo executados por trás de firewalls com alguma funcionalidade (a saber, o comando `system`) desabilitado. 

Para verificar se o endpoint selecionado irá funcionar para votação, execute: 

`cleos -u http://api.eosnewyork.io:80 system listproducers`

Se você receber de volta uma lista de produtores, então você deve estar ok. 
### Endpoints da API do Testnet

* `https://jungle.eosio.cr:443`


### Execute seu próprio endpoint 

Embora isso seja mais complexo, executar seu próprio nó fornece controle total. 

Em um servidor Ubuntu 16 fresco (use seu servidor de escolha, é claro, mas essas instruções foram executadas nesse SO) - Note que você precisa de pelo menos 16GB ou memória RAM e no mínimo 20GB de espaço em disco antes de poder iniciar este processo. Também não que isso demore muito tempo, espere 24 horas antes que seu nó esteja em um estado utilizável. 

Clone o repositório e compile o software

```
git clone https://github.com/EOSIO/eos.git --recursive
cd eos/
./eosio_build.sh
cd build/
sudo make install
```

Pegue uma cópia dos blocos e prepare o env.

Uma cópia recente dos dados do blockchain pode ser encontrada em https://eosnode.tools/blocks (Fornecido por Block Matrix - https://blockmatrix.network/)

```
sudo su 
~~ Não é uma prática recomendada, mas a seguinte é executada como root ~~
mkdir /eos
md /eos
mkdir data
wget {Get URL to tar file from https://eosnode.tools/blocks}
tar -zxvf blocks_2018-08-09-10-22.tar.gz
mv mnt/blocks /eos/data
```

Adicione config.ini à pasta /eos. 

{Pretendemos fornecer um arquivo de configuração sugerido aqui no futuro para ajudar aqueles que não estão familiarizados com a configuração do Node, enquanto isso, entre em contato com a EOS New York para solicitar assistência}

```
/usr/local/eosio/bin/nodeos -d /eos/data --config-dir=/oes --hard-replay-blockchain
.... aguarde ... e aguarde mais ... pode levar muitas horas até que o replay termine, ponto em que o nó estará sincronizado com a rede. 
```
