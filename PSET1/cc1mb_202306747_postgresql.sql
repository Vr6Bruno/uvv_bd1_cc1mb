
/*Exclui o banco de dados e o usuário*/

DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS bruno;

/*Cria o banco de dados e o usuário */

CREATE USER bruno WITH PASSWORD 'computacao@raiz';
CREATE DATABASE uvv
owner bruno
template template0
encoding 'UTF8'
lc_collate 'pt_BR.UTF-8'
lc_ctype 'pt_BR.UTF-8'
allow_connections TRUE;

-- Troca de conexão;

\c 'dbname=uvv user=bruno password=computacao@raiz';

/*Cria o esquema lojas onde será inserido o banco de dados uvv*/

CREATE SCHEMA lojas AUTHORIZATION bruno;

ALTER USER bruno
SET SEARCH_PATH TO lojas, "$user", public;
SET SEARCH_PATH TO lojas, "$user", public;


-- Cria a Tabela produtos;

CREATE TABLE produtos (
                produto_id                                         NUMERIC(38)        NOT NULL,
                nome                                               VARCHAR(255)       NOT NULL,
                preco_unitario                                     NUMERIC(10,2),
                detalhes                                           BYTEA,
                imagem                                             BYTEA,
                imagem_mime_type                                   VARCHAR(512),
                imagem_arquivo                                     VARCHAR(512),
                imagem_charset                                     VARCHAR(512),
                imagem_ultima_atualizacao                          DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE produtos                                          IS                 'Tabela referente aos produtos das lojas UVV.';
COMMENT ON COLUMN produtos.produto_id                              IS                 'Número de identificação de cada produto das lojas UVV.';
COMMENT ON COLUMN produtos.nome                                    IS                 'Nome de cada produto das lojas UVV.';
COMMENT ON COLUMN produtos.preco_unitario                          IS                 'Valor de cada produto das lojas UVV.';
COMMENT ON COLUMN produtos.detalhes                                IS                 'Informações sobre cada produto das lojas UVV.';
COMMENT ON COLUMN produtos.imagem                                  IS                 'Imagem de cada produto das lojas UVV.';
COMMENT ON COLUMN produtos.imagem_mime_type                        IS                 'Informa os dados das imagens das lojas UVV.';
COMMENT ON COLUMN produtos.imagem_arquivo                          IS                 'Arquivo no qual se encontram as imagens de cada produto.';
COMMENT ON COLUMN produtos.imagem_charset                          IS                 'Exibe dados usados para mostrar as imagens dos produtos.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao               IS                 'Mostra a data da última atualização feita nas imagens dos produtos.';

-- Cria a Tabela lojas;

CREATE TABLE lojas (
                loja_id                                            NUMERIC(38)         NOT NULL,
                nome                                               VARCHAR(255)        NOT NULL,
                endereco_web                                       VARCHAR(100),
                endereco_fisico                                    VARCHAR(512),
                latitude                                           NUMERIC,
                longitude                                          NUMERIC,
                logo                                               BYTEA,
                logo_mime_type                                     VARCHAR(512),
                logo_arquivo                                       VARCHAR(512),
                logo_charset                                       VARCHAR(512),
                logo_ultima_atualizacao                            DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE lojas                                             IS                  'Tabela com as informações das lojas UVV.';
COMMENT ON COLUMN lojas.loja_id                                    IS                  'Número de identificação das lojas UVV.';
COMMENT ON COLUMN lojas.nome                                       IS                  'Nome de cada loja UVV.';
COMMENT ON COLUMN lojas.endereco_web                               IS                  'Endereço do site das lojas UVV.';
COMMENT ON COLUMN lojas.endereco_fisico                            IS                  'Endereço da localização de cada loja UVV.';
COMMENT ON COLUMN lojas.latitude                                   IS                  'Coordenadas latitudinais das lojas UVV.';
COMMENT ON COLUMN lojas.longitude                                  IS                  'Coordenadas longitudinais das lojas UVV.';
COMMENT ON COLUMN lojas.logo                                       IS                  'Imagem que identifica as lojas UVV.';
COMMENT ON COLUMN lojas.logo_mime_type                             IS                  'Informa os dados da logo das lojas UVV.';
COMMENT ON COLUMN lojas.logo_arquivo                               IS                  'Arquivo no qual se encontra a logo da lojas UVV.';
COMMENT ON COLUMN lojas.logo_charset                               IS                  'Exibe dados usados para mostrar a logo das lojas UVV.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao                    IS                  'Mostra a data da última atualização feita na logo.';

-- Cria a Tabela estoques;

CREATE TABLE estoques (
                estoque_id                                         NUMERIC(38)          NOT NULL,
                loja_id                                            NUMERIC(38)          NOT NULL,
                produto_id                                         NUMERIC(38)          NOT NULL,
                quantidade                                         NUMERIC(38)          NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE estoques                                          IS                  'Tabela referente aos produtos nos estoques.';
COMMENT ON COLUMN estoques.estoque_id                              IS                  'Número para identificar o estoque de cada loja UVV.';
COMMENT ON COLUMN estoques.loja_id                                 IS                  'Número de identificação das lojas UVV.';
COMMENT ON COLUMN estoques.produto_id                              IS                  'Número de identificação de cada produto das lojas UVV.';
COMMENT ON COLUMN estoques.quantidade                              IS                  'Quantidade de produtos nos estoques das lojas UVV';

-- Cria a Tabela clientes;

CREATE TABLE clientes (
                cliente_id                                         NUMERIC(38)         NOT NULL,
                email                                              VARCHAR(255)        NOT NULL,
                nome                                               VARCHAR(255)        NOT NULL,
                telefone1                                          VARCHAR(20),
                telefone2                                          VARCHAR(20),
                telefone3                                          VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE clientes                                          IS                  'Tabela com as informações dos clientes das lojas UVV.';
COMMENT ON COLUMN clientes.cliente_id                              IS                  'Número de identificação dos clientes, como o CPF.';
COMMENT ON COLUMN clientes.email                                   IS                  'Email, para contato, do cliente.';
COMMENT ON COLUMN clientes.nome                                    IS                  'Nome dos clientes das lojas UVV.';
COMMENT ON COLUMN clientes.telefone1                               IS                  'Primeiro número de contato dos clientes.';
COMMENT ON COLUMN clientes.telefone2                               IS                  'Segundo número de contato dos clientes.';
COMMENT ON COLUMN clientes.telefone3                               IS                  'Terceiro número de contato dos clientes.';

-- Cria a Tabela pedidos;

CREATE TABLE pedidos (
                pedido_id                                          NUMERIC(38)          NOT NULL,
                data_hora                                          TIMESTAMP            NOT NULL,
                cliente_id                                         NUMERIC(38)          NOT NULL,
                status                                             VARCHAR(15)          NOT NULL,
                loja_id                                            NUMERIC(38)          NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE pedidos                                           IS                   'Tabela referente aos pedidos feitos pelos clientes.';
COMMENT ON COLUMN pedidos.pedido_id                                IS                   'Número de identificação dos pedidos dos clientes.';
COMMENT ON COLUMN pedidos.data_hora                                IS                   'A data e a hora do pedidos feitos pelos clientes.';
COMMENT ON COLUMN pedidos.cliente_id                               IS                   'Número de identificação dos clientes, como o CPF.';
COMMENT ON COLUMN pedidos.status                                   IS                   'Andamento dos pedidos feitos pelos clientes.';
COMMENT ON COLUMN pedidos.loja_id                                  IS                   'Número de identificação das lojas UVV.';

-- Cria a Tabela envios;

CREATE TABLE envios (
                envio_id                                           NUMERIC(38)           NOT NULL,
                loja_id                                            NUMERIC(38)           NOT NULL,
                cliente_id                                         NUMERIC(38)           NOT NULL,
                endereco_entrega                                   VARCHAR(512)          NOT NULL,
                status                                             VARCHAR(15)           NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE envios                                            IS                   'Tabela referente aos produtos enviados aos clientes.';
COMMENT ON COLUMN envios.envio_id                                  IS                   'Número dos produtos enviados.';
COMMENT ON COLUMN envios.loja_id                                   IS                   'Número de identificação das lojas UVV.';
COMMENT ON COLUMN envios.cliente_id                                IS                   'Número de identificação dos clientes, como o CPF.';
COMMENT ON COLUMN envios.endereco_entrega                          IS                   'Endereço do local de entrega dos produtos.';
COMMENT ON COLUMN envios.status                                    IS                   'Mostra o andamento da entrega dos produtos.';

-- Cria a Tabela pedidos_itens;

CREATE TABLE pedidos_itens (
                pedido_id                                          NUMERIC(38)           NOT NULL,
                produto_id                                         NUMERIC(38)           NOT NULL,
                numero_da_linha                                    NUMERIC(38)           NOT NULL,
                preco_unitario                                     NUMERIC(10,2)         NOT NULL,
                quantidade                                         NUMERIC(38)           NOT NULL,
                envio_id                                           NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

-- Comentários da Tabela e Colunas;

COMMENT ON TABLE pedidos_itens                                     IS                    'Tabela referente aos itens pedidos pelos clientes.';
COMMENT ON COLUMN pedidos_itens.pedido_id                          IS                    'Número de identificação dos pedidos dos clientes.';
COMMENT ON COLUMN pedidos_itens.produto_id                         IS                    'Número de identificação de cada produto das lojas UVV.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha                    IS                    'Numeração das linhas dos itens pedidos pelos clientes.';
COMMENT ON COLUMN pedidos_itens.preco_unitario                     IS                    'Valor de cada produto pedido pelos clientes.';
COMMENT ON COLUMN pedidos_itens.quantidade                         IS                    'Quantidade de produtos pedidos pelos clientes.';
COMMENT ON COLUMN pedidos_itens.envio_id                           IS                    'Número dos produtos enviados.';

/*Esses comandos são responsáveis por gerar as chaves estrangeiras para todas as tabelas do banco de dados uvv*/

ALTER TABLE estoques                                               ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens                                          ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios                                                 ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos                                                ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques                                               ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios                                                 ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos                                                ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens                                          ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens                                          ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/*Essas restrições são usadas para impedir que valores das colunas preço unitário e quantidade sejam negativas, além disso nas colunas status, só poderá aparecer aqueles valores mencionado nos comandos, tanto na tabela envios quanto pedidos, e por fim, quando gerar tabelas referente as colunas endereço web ou físico as colunas da tabela ficarão preenchidas*/


ALTER TABLE envios            ADD CONSTRAINT status_envios                 CHECK (status IN('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));



ALTER TABLE pedidos           ADD CONSTRAINT status_pedidos                CHECK (status IN('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSO', 'ENVIADO'));

 

ALTER TABLE pedidos_itens     ADD CONSTRAINT preco_unitario_pedidos_itens  CHECK (preco_unitario >=0);



ALTER TABLE produtos          ADD CONSTRAINT preco_unitario_produtos       CHECK (preco_unitario >=0);



ALTER TABLE estoques          ADD CONSTRAINT quantidade_estoques           CHECK (quantidade >=0);



ALTER TABLE pedidos_itens     ADD CONSTRAINT quantidade_pedidos_itens      CHECK (quantidade >=0);



ALTER TABLE lojas             ADD CONSTRAINT endereco_lojas                CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);


