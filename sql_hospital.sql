-- Database: hospital

-- DROP DATABASE hospital;

CREATE DATABASE hospital
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
CREATE TABLE empregado (
  matricula INTEGER  NOT NULL,
  cpf INTEGER  NOT NULL,
  nome VARCHAR(45) NULL,
  sexo CHAR NULL,
  telefone INTEGER NULL,
  rua VARCHAR(45) NULL,
  numero INTEGER  NULL,
  bairro VARCHAR(45) NULL,
  cep INTEGER  NULL,
  cidade VARCHAR(45) NULL,
  estado VARCHAR(2) NULL,
  PRIMARY KEY(matricula)
);

CREATE TABLE enfermeiro (
  CRE INTEGER  NOT NULL,
  empregado_matricula INTEGER NOT NULL,
  PRIMARY KEY(CRE),
  INDEX enfermeiro_FKIndex2(empregado_matricula)
);

CREATE TABLE medico (
  CRM INTEGER  NOT NULL,
  empregado_matricula INTEGER  NOT NULL,
  PRIMARY KEY(CRM),
  INDEX medico_FKIndex1(empregado_matricula)
);

CREATE TABLE area_especialidade (
  codigo_esp INTEGER  NOT NULL ,
  medico_CRM INTEGER  NOT NULL,
  tipo VARCHAR(45) NULL,
  PRIMARY KEY(codigo_esp),
  INDEX area_especialidade_FKIndex1(medico_CRM)
);

CREATE TABLE ala (
  codigo_ala INTEGER  NOT NULL,
  enfermeiro_CRE INTEGER  NOT NULL,
  area_especialidade_codigo_esp INTEGER  NOT NULL,
  local_ala VARCHAR(45) NULL,
  quant_leitos INTEGER  NULL,
  PRIMARY KEY(codigo_ala),
  INDEX ala_FKIndex1(enfermeiro_CRE),
  INDEX ala_FKIndex2(area_especialidade_codigo_esp)
);

CREATE TABLE leito (
  codigo_leito INTEGER  NOT NULL ,
  ala_codigo_ala INTEGER  NOT NULL,
  PRIMARY KEY(codigo_leito),
  INDEX leito_FKIndex1(ala_codigo_ala)
);

CREATE TABLE paciente (
  cpf INTEGER  NOT NULL ,
  convenio_id_convenio INTEGER  NOT NULL,
  leito_codigo_leito INTEGER  NOT NULL,
  nome VARCHAR(45) NULL,
  telefone INTEGER  NULL,
  rua VARCHAR(45) NULL,
  numero INTEGER  NULL,
  complemento VARCHAR(45) NULL,
  bairro VARCHAR(45) NULL,
  cep INTEGER  NULL,
  cidade VARCHAR(45) NULL,
  estado VARCHAR(2) NULL,
  PRIMARY KEY(cpf),
  INDEX paciente_FKIndex1(leito_codigo_leito),
  INDEX paciente_FKIndex2(convenio_id_convenio)
);

CREATE TABLE convenio (
  id_convenio INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  telefone INTEGER  NULL,
  PRIMARY KEY(id_convenio)
);

CREATE TABLE medicamento (
  id_medicamento INTEGER  NOT NULL,
  nome VARCHAR(45) NULL,
  quantidade INTEGER NULL,
  PRIMARY KEY(id_medicamento)
);

CREATE TABLE fornecedor (
  CNPJ INTEGER  NOT NULL,
  nome VARCHAR(45) NULL,
  telefone INTEGER NULL,
  PRIMARY KEY(CNPJ)
);

CREATE TABLE medicamento_fornecido (
  medicamento_id_medicamento INTEGER NOT NULL,
  fornecedor_CNPJ INTEGER  NOT NULL,
  PRIMARY KEY(medicamento_id_medicamento, fornecedor_CNPJ),
  INDEX medicamento_has_fornecedor_FKIndex1(medicamento_id_medicamento),
  INDEX medicamento_has_fornecedor_FKIndex2(fornecedor_CNPJ)
);

CREATE TABLE prontuario (
  data_internamento INTEGER  NOT NULL,
  hora_internamento INTEGER NOT NULL,
  medicamento_id_medicamento INTEGER NOT NULL,
  pagamento_codigo_pagamento INTEGER NOT NULL,
  leito_codigo_leito INTEGER  NOT NULL,
  medico_CRM INTEGER  NOT NULL,
  paciente_cpf INTEGER NOT NULL,
  enfermidade VARCHAR(45) NULL,
  PRIMARY KEY(data_internamento, hora_internamento),
  INDEX prontuario_FKIndex1(paciente_cpf),
  INDEX prontuario_FKIndex2(medico_CRM),
  INDEX prontuario_FKIndex3(leito_codigo_leito),
  INDEX prontuario_FKIndex4(pagamento_codigo_pagamento),
  INDEX prontuario_FKIndex5(medicamento_id_medicamento)
);

CREATE TABLE pagamento (
  codigo_pagamento INTEGER NOT NULL,
  pag_particular_cartao INTEGER NOT NULL,
  pag_particular_a_vista INTEGER NOT NULL,
  convenio_id_convenio INTEGER NOT NULL,
  descricao VARCHAR(45) NULL,
  valor FLOAT NULL,
  PRIMARY KEY(codigo_pagamento),
  INDEX pagamento_FKIndex1(convenio_id_convenio),
  INDEX pagamento_FKIndex2(pag_particular_a_vista, pag_particular_cartao)
);

CREATE TABLE pag_particular (
  a_vista INTEGER NOT NULL,
  cartao INTEGER NOT NULL,
  PRIMARY KEY(a_vista, cartao)
);



	