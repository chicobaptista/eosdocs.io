---
title: "Armazenamento de Dados"
date: 2018-04-30T15:53:46-04:00
draft: false
weight: 8
---

### Armazenamento
A realização de operações CRUD contra contratos inteligentes EOS é obtida com a interface eosio::multi_index, que traz funcionalidades que podem ser comparadas a um banco de dados tradicional 


### Contrato To Do

Neste artigo, criaremos um contrato inteligente simples de tarefas que permite ao usuário adicionar um elemento 'todo', por exemplo, "alimentar o gato" e marcá-lo como completo. 

No diretório de contratos, crie uma nova pasta "todo_contract" e um novo arquivo CPP com o mesmo nome.
```
mkdir todo_contract
cd todo_contract
touch todo_contract.cpp
vim todo_contract.cpp
```

Alternativamente, você pode usar o eosiocpp para gerar um boilerplate para o projeto, incluindo a pasta do projeto. Na sua pasta de projetos de nível superior, execute o seguinte:
```
eosiocpp -n todo_contract
```
Isto lhe dará a seguinte estrutura de pastas:
```
.
├── todo_contract.cpp
└── todo_contract.hpp

0 directories, 2 files
```

Demonstraremos as funcionalidades Criar, Atualizar e Excluir com nossas ações ABI 
- create(author, id, description) 
- destroy(author, id)
- complete(author, id)

Nossos elementos todo têm 3 propriedades simples. 
```
{
	id,
	description,
	completed
}

```

que como uma struct parece

```
// @abi table todos i64
struct todo {
	uint64_t id;
	std::string description;
	uint64_t completed;

	uint64_t primary_key() const { return id; }
	EOSLIB_SERIALIZE(todo, (id)(description)(completed))
};
```

### Criar função
A função create cria um novo elemento todo usando o método [emplace] (https://github.com/EOSIO/eos/wiki/Persistence-API#emplace). O primeiro parâmetro é o pagador, uma conta válida que autorizou a ação atual (e, portanto, pode ser cobrada pelo uso de armazenamento)

```
// @abi action
void create(account_name author, const uint32_t id, const std::string& description) {
	todos.emplace(author, [&](auto& new_todo) {
		new_todo.id  = id;
		new_todo.description = description;
		new_todo.completed = 0;
});
```



### Função Destruir

O método [erase] (https://github.com/EOSIO/eos/wiki/Persistence-API#erase) removerá o objeto da tabela e reembolsará o pagador existente pelo armazenamento dele. 
```
// @abi action
void destroy(account_name author, const uint32_t id) {
	auto todo_lookup = todos.find(id);
	todos.erase(todo_lookup);

	eosio::print("todo#", id, " destroyed");
}
```

### Função Completar

Completamos a nossa tarefa simplesmente alterando a propriedade concluída de 0 para 1 com o método [modify] (https://github.com/EOSIO/eos/wiki/Persistence-API#modify-1). 

O segundo parâmetro usado no método modify é o *payer* (account_name)

Passar 0 indica que o pagador da linha recém-modificada é o mesmo que o original. 

Se o novo pagador é o mesmo que o antigo, ele paga apenas a diferença entre o objeto antigo e o novo. 

Se o novo pagador não for o antigo, o antigo será reembolsado pelo uso de armazenamento do objeto existente e o novo pagador será responsável.  

```
    // @abi action
    void complete(account_name author, const uint32_t id) {
      auto todo_lookup = todos.find(id);
      eosio_assert(todo_lookup != todos.end(), "Todo does not exist");

      todos.modify(todo_lookup, author, [&](auto& modifiable_todo) {
        modifiable_todo.completed = 1;
      });

      eosio::print("todo#", id, " marked as complete");
    }
```

## Configuração de tabelas

Vamos agora configurar o contêiner, pense nisso como a tabela. 
```
typedef eosio::multi_index<N(todos), todo> todo_table;
todo_table todos;
```

## Implementação
Código completo disponível na EOS Asia [aqui](https://github.com/eosasia/eos-todo/blob/master/contract/todo.cpp)

```
eosiocpp -o todo_contract.wast todo_contract.cpp
eosiocpp -g todo_contract.abi todo_contract.cpp
cleos --wallet-url http://wallet:5555 -u http://server:7777 set contract mynewaccount /eos/contracts/todo_contract -p mynewaccount
```

## Interação
### Get 
```
cleos --wallet-url http://wallet:5555 -u http://server:7777 get table mynewaccount todo todos
```

### Create
```
cleos --wallet-url http://wallet:5555 -u http://server:7777 push action mynewaccount create '["mynewaccount", 1, "feed cat"]' -p mynewaccount
```

### Complete
```
cleos --wallet-url http://wallet:5555 -u http://server:7777 push action mynewaccount complete '["mynewaccount", 1]' -p mynewaccount
```

### Destroy
```
cleos --wallet-url http://wallet:5555 -u http://server:7777 push action mynewaccount destroy '["mynewaccount", 1]' -p mynewaccount
```

____________

Mais recursos sobre armazenamento

* Este vídeo https://youtu.be/E3Tx2DseLGE por Object Computing
	* [Escrevendo para tabelas (armazenamento)](https://youtu.be/E3Tx2DseLGE?t=50m27s) (50 minutos - 1 hora)
	* [Excluindo de uma tabela (armazenamento)](https://youtu.be/E3Tx2DseLGE?t=1h00m00s) (1 h - 1h 3 minutos)
	* [Usando um índice de tabela alternativa (armazenamento)](https://youtu.be/E3Tx2DseLGE?t=1h03m00s) (1h 3 minutos - 1h 4 minutos)
	* [Definindo quem paga pelo armazenamento](https://youtu.be/E3Tx2DseLGE?t=56m36s) (56 minutos - 58 minutos)
