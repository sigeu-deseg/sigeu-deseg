
CREATE TABLE public.instituicao (
                id_instituicao INTEGER NOT NULL,
                sigla VARCHAR(10) NOT NULL,
                nome VARCHAR(200) NOT NULL,
                ativo BOOLEAN DEFAULT true NOT NULL,
                url_logo VARCHAR(1024),
                CONSTRAINT pk_instituicao PRIMARY KEY (id_instituicao)
);


CREATE TABLE public.campus (
                id_campus INTEGER NOT NULL,
                id_instituicao INTEGER NOT NULL,
                sigla VARCHAR(10) NOT NULL,
                nome VARCHAR(200) NOT NULL,
                url_logo VARCHAR(1024),
                ativo BOOLEAN DEFAULT true NOT NULL,
                CONSTRAINT pk_campus PRIMARY KEY (id_campus)
);


CREATE UNIQUE INDEX ak_campus_id
 ON public.campus
 ( id_campus );

CREATE UNIQUE INDEX ak_campus_sigla
 ON public.campus
 ( sigla, id_instituicao );

CREATE INDEX ak_campus_nome
 ON public.campus
 ( nome, id_instituicao );

CREATE TABLE public.mail_server (
                id_campus INTEGER NOT NULL,
                authentication_required BOOLEAN DEFAULT false NOT NULL,
                starttls BOOLEAN DEFAULT false NOT NULL,
                ssl BOOLEAN DEFAULT false NOT NULL,
                plain_text_over_tls BOOLEAN DEFAULT false NOT NULL,
                host VARCHAR(255) NOT NULL,
                port INTEGER NOT NULL,
                from_email VARCHAR(255) NOT NULL,
                user_name VARCHAR(32) NOT NULL,
                password VARCHAR(2000) NOT NULL,
                CONSTRAINT pk_mail_server PRIMARY KEY (id_campus)
);
COMMENT ON TABLE public.mail_server IS 'Configura��es da conta e servidor de e-mails';


CREATE TABLE public.tipo_reserva (
                id_tipo_reserva INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                descricao VARCHAR(100) NOT NULL,
                ativo BOOLEAN DEFAULT true NOT NULL,
                CONSTRAINT pk_tipo_reserva PRIMARY KEY (id_tipo_reserva)
);


CREATE TABLE public.timetable (
                id_timetable INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                nome_arquivo VARCHAR(256) NOT NULL,
                data_carregamento TIMESTAMP NOT NULL,
                CONSTRAINT pk_timetable PRIMARY KEY (id_timetable)
);


CREATE TABLE public.card (
                id_card INTEGER NOT NULL,
                id_timetable INTEGER NOT NULL,
                lessonid VARCHAR(32) NOT NULL,
                classroomids VARCHAR(2000) NOT NULL,
                period VARCHAR(32) NOT NULL,
                days VARCHAR(32) NOT NULL,
                CONSTRAINT pk_card PRIMARY KEY (id_card)
);


CREATE TABLE public.lesson (
                id_lesson INTEGER NOT NULL,
                id VARCHAR(32) NOT NULL,
                id_timetable INTEGER NOT NULL,
                classids VARCHAR(2000) NOT NULL,
                subjectids VARCHAR(2000) NOT NULL,
                teacherids VARCHAR(2000) NOT NULL,
                classroomids VARCHAR(2000) NOT NULL,
                CONSTRAINT pk_lesson PRIMARY KEY (id_lesson)
);


CREATE UNIQUE INDEX ak_lesson_id
 ON public.lesson
 ( id, id_timetable );

CREATE TABLE public.classroom (
                id_classroom INTEGER NOT NULL,
                id VARCHAR(32) NOT NULL,
                name VARCHAR(100) NOT NULL,
                shortname VARCHAR(32) NOT NULL,
                id_timetable INTEGER NOT NULL,
                CONSTRAINT pk_classroom PRIMARY KEY (id_classroom)
);


CREATE UNIQUE INDEX ak_classroom_id
 ON public.classroom
 ( id_classroom, id );

CREATE TABLE public.teacher (
                id_teacher INTEGER NOT NULL,
                id_timetable INTEGER NOT NULL,
                id VARCHAR(32) NOT NULL,
                name VARCHAR(100) NOT NULL,
                shortname VARCHAR(32) NOT NULL,
                gender CHAR(1) NOT NULL,
                color VARCHAR(10) NOT NULL,
                CONSTRAINT pk_teacher PRIMARY KEY (id_teacher)
);


CREATE UNIQUE INDEX ak_teacher_id
 ON public.teacher
 ( id_timetable, id );

CREATE TABLE public.clazz (
                id_clazz INTEGER NOT NULL,
                id_timetable INTEGER NOT NULL,
                id VARCHAR(32) NOT NULL,
                name VARCHAR(100) NOT NULL,
                shortname VARCHAR(32) NOT NULL,
                CONSTRAINT pk_clazz PRIMARY KEY (id_clazz)
);


CREATE UNIQUE INDEX ak_id
 ON public.clazz
 ( id_timetable, id );

CREATE TABLE public.subject (
                id_subject INTEGER NOT NULL,
                id_timetable INTEGER NOT NULL,
                id VARCHAR(32) NOT NULL,
                name VARCHAR(100) NOT NULL,
                shortname VARCHAR(32) NOT NULL,
                CONSTRAINT pk_subject PRIMARY KEY (id_subject)
);


CREATE UNIQUE INDEX ak_subject_id
 ON public.subject
 ( id_timetable, id );

CREATE TABLE public.period (
                id_period INTEGER NOT NULL,
                name VARCHAR(100) NOT NULL,
                id_timetable INTEGER NOT NULL,
                shortname VARCHAR(100) NOT NULL,
                starttime TIME NOT NULL,
                endtime TIME NOT NULL,
                ordem INTEGER NOT NULL,
                CONSTRAINT pk_period PRIMARY KEY (id_period)
);


CREATE UNIQUE INDEX ak_period_name
 ON public.period
 ( id_period, name );

CREATE TABLE public.classe (
                id_classe INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                codigo VARCHAR(32),
                nome VARCHAR(32) NOT NULL,
                rotulo VARCHAR(12) NOT NULL,
                CONSTRAINT pk_classe PRIMARY KEY (id_classe)
);
COMMENT ON TABLE public.classe IS 'Turma de aula';


CREATE UNIQUE INDEX ak_classe_id
 ON public.classe
 ( id_classe );

CREATE TABLE public.feriado (
                id_feriado INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                data DATE NOT NULL,
                tipo CHAR(1) DEFAULT 'F' NOT NULL,
                descricao VARCHAR(128) NOT NULL,
                CONSTRAINT pk_feriado PRIMARY KEY (id_feriado)
);
COMMENT ON TABLE public.feriado IS 'feriados e recessos';
COMMENT ON COLUMN public.feriado.tipo IS '[F]eriado, [R]ecesso';


CREATE TABLE public.disciplina (
                id_disciplina INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                codigo VARCHAR(32),
                nome VARCHAR(64) NOT NULL,
                rotulo VARCHAR(12) NOT NULL,
                CONSTRAINT pk_disciplina PRIMARY KEY (id_disciplina)
);


CREATE UNIQUE INDEX ak_disciplina_codigo
 ON public.disciplina
 ( id_campus, codigo );

CREATE TABLE public.professor (
                id_professor INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                codigo VARCHAR(32),
                name VARCHAR(128) NOT NULL,
                genero CHAR(1) NOT NULL,
                cor VARCHAR(12),
                CONSTRAINT pk_professor PRIMARY KEY (id_professor)
);
COMMENT ON TABLE public.professor IS 'Tabela de professores para defini��o de aulas';
COMMENT ON COLUMN public.professor.codigo IS 'C�digo alternativo';


CREATE UNIQUE INDEX ak_professor_id
 ON public.professor
 ( id_professor );

CREATE TABLE public.categoria_item_reserva (
                id_categoria INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                nome VARCHAR(64) NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT pk_categoria_item_reserva PRIMARY KEY (id_categoria)
);


CREATE UNIQUE INDEX ak_categoria_item_reserva_id
 ON public.categoria_item_reserva
 ( id_categoria );

CREATE UNIQUE INDEX ak_categoria_item_reserva_nome
 ON public.categoria_item_reserva
 ( nome, id_campus );

CREATE TABLE public.item_reserva (
                id_item_reserva INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                id_categoria INTEGER NOT NULL,
                nome VARCHAR(64) NOT NULL,
                rotulo VARCHAR(32) NOT NULL,
                patrimonio VARCHAR(32),
                detalhes TEXT,
                ativo BOOLEAN DEFAULT true NOT NULL,
                codigo VARCHAR(32),
                CONSTRAINT pk_item_reserva PRIMARY KEY (id_item_reserva)
);
COMMENT ON COLUMN public.item_reserva.detalhes IS 'Descricao detalhada do item a ser reservado';


CREATE UNIQUE INDEX ak_item_reserva_nome
 ON public.item_reserva
 ( nome, id_campus );

CREATE UNIQUE INDEX ak_item_reserva_rotulo
 ON public.item_reserva
 ( rotulo, id_campus );

CREATE TABLE public.ldap_server (
                id_server INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                host VARCHAR(256) NOT NULL,
                port INTEGER NOT NULL,
                ssl BOOLEAN DEFAULT false NOT NULL,
                basedn VARCHAR(2000) NOT NULL,
                sufixo_email VARCHAR(256) NOT NULL,
                var_ldap_nome_completo VARCHAR(32),
                var_ldap_email VARCHAR(32),
                var_ldap_cnpj_cpf VARCHAR(32),
                var_ldap_matricula VARCHAR(32),
                var_ldap_uid VARCHAR(32),
                var_ldap_campus VARCHAR(32) NOT NULL,
                ativo BOOLEAN DEFAULT true NOT NULL,
                CONSTRAINT pk_ldap_server PRIMARY KEY (id_server)
);
COMMENT ON TABLE public.ldap_server IS 'Informa��es do servidor LDAP';


CREATE UNIQUE INDEX ak_ldap_sufixo_email
 ON public.ldap_server
 ( sufixo_email ASC );

CREATE UNIQUE INDEX ak_ldap_server_id
 ON public.ldap_server
 ( id_server );

CREATE TABLE public.sequencia (
                nome VARCHAR(64) NOT NULL,
                valor BIGINT DEFAULT 1 NOT NULL,
                CONSTRAINT pk_sequencia PRIMARY KEY (nome)
);
COMMENT ON TABLE public.sequencia IS 'Tabela para armazenamento de sequencias de c�digos (contadores)';
COMMENT ON COLUMN public.sequencia.nome IS 'Nome do contador de sequencia';
COMMENT ON COLUMN public.sequencia.valor IS 'Valor do pr�ximo contador a ser recuperado para utiliza��o.';


CREATE TABLE public.grupo_pessoa (
                id_grupo_pessoa INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                nome VARCHAR(200) NOT NULL,
                CONSTRAINT pk_grupo_pessoa PRIMARY KEY (id_grupo_pessoa)
);


CREATE UNIQUE INDEX ak_grupo_pessoa_descricao
 ON public.grupo_pessoa
 ( nome, id_campus );

CREATE TABLE public.parametro (
                codigo VARCHAR(64) NOT NULL,
                valor TEXT NOT NULL,
                CONSTRAINT pk_parametro PRIMARY KEY (codigo)
);
COMMENT ON COLUMN public.parametro.codigo IS 'C�digo interno do par�metro';


CREATE SEQUENCE public.pessoa_id_pessoa_seq;

CREATE TABLE public.pessoa (
                id_pessoa INTEGER NOT NULL DEFAULT nextval('public.pessoa_id_pessoa_seq'),
                id_campus INTEGER NOT NULL,
                email VARCHAR(254) NOT NULL,
                nome_completo VARCHAR(200) NOT NULL,
                senha_md5 CHAR(32) NOT NULL,
                pessoa_fisica BOOLEAN DEFAULT true NOT NULL,
                cnpj_cpf VARCHAR(20),
                matricula VARCHAR(32),
                ativo BOOLEAN DEFAULT true NOT NULL,
                admin BOOLEAN DEFAULT false NOT NULL,
                CONSTRAINT pk_pessoa PRIMARY KEY (id_pessoa)
);
COMMENT ON COLUMN public.pessoa.pessoa_fisica IS 'Rar�ssimos casos onde uma pessoa jur�dica pode se conectar devem ser cadastrados com o valor falso. Nesse caso, � preciso preencher os campos cnpf_cpf e ie';
COMMENT ON COLUMN public.pessoa.cnpj_cpf IS 'CNPJ para pessoas jur�dicas ou CPF para pessoas f�sicas.';


ALTER SEQUENCE public.pessoa_id_pessoa_seq OWNED BY public.pessoa.id_pessoa;

CREATE UNIQUE INDEX ak_pessoa_email
 ON public.pessoa
 ( email ASC, id_campus ASC );

CREATE TABLE public.autorizacao_item_reserva (
                id_item_reserva INTEGER NOT NULL,
                id_pessoa INTEGER NOT NULL,
                CONSTRAINT pk_autorizacao_item_reserva PRIMARY KEY (id_item_reserva, id_pessoa)
);
COMMENT ON TABLE public.autorizacao_item_reserva IS 'Rela��o de pessoas que podem autorizar a reserva de um item.';


CREATE TABLE public.professor_pessoa (
                id_professor INTEGER NOT NULL,
                id_pessoa INTEGER NOT NULL,
                CONSTRAINT pk_professor_pessoa PRIMARY KEY (id_professor)
);


CREATE TABLE public.transacao (
                id_transacao INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                id_pessoa INTEGER NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                descricao VARCHAR(512) NOT NULL,
                CONSTRAINT pk_transacao PRIMARY KEY (id_transacao)
);
COMMENT ON TABLE public.transacao IS 'Informa��es sobre cada opera��o realizada no sistema.';
COMMENT ON COLUMN public.transacao.descricao IS 'Descri��o gravada pelo sistema sobre a opera��o';


CREATE TABLE public.periodo_letivo (
                id_periodo_letivo INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                nome VARCHAR(32) NOT NULL,
                data_inicio DATE NOT NULL,
                data_fim DATE NOT NULL,
                id_transacao_reserva INTEGER,
                CONSTRAINT pk_periodo_letivo PRIMARY KEY (id_periodo_letivo)
);


CREATE UNIQUE INDEX ak_periodo_letivo_data
 ON public.periodo_letivo
 ( data_inicio, id_campus );

CREATE UNIQUE INDEX ak_periodo_letivo_nome
 ON public.periodo_letivo
 ( nome, id_campus );

CREATE SEQUENCE public.reserva_id_reserva_seq;

CREATE TABLE public.reserva (
                id_reserva INTEGER NOT NULL DEFAULT nextval('public.reserva_id_reserva_seq'),
                id_transacao INTEGER NOT NULL,
                id_campus INTEGER NOT NULL,
                data_gravacao DATE DEFAULT current_date NOT NULL,
                hora_gravacao TIME DEFAULT CURRENT_TIME NOT NULL,
                data DATE NOT NULL,
                hora_inicio TIME NOT NULL,
                hora_fim TIME NOT NULL,
                id_tipo_reserva INTEGER NOT NULL,
                id_item_reserva INTEGER NOT NULL,
                id_pessoa INTEGER NOT NULL,
                id_autorizador INTEGER NOT NULL,
                id_usuario INTEGER NOT NULL,
                nome_usuario VARCHAR(255) NOT NULL,
                email_notificacao VARCHAR(256) NOT NULL,
                motivo VARCHAR(4000) NOT NULL,
                rotulo VARCHAR(32) NOT NULL,
                cor VARCHAR(12) DEFAULT '#BBD2D2' NOT NULL,
                status CHAR(1) DEFAULT 'E' NOT NULL,
                motivo_cancelamento VARCHAR(4000),
                importado BOOLEAN DEFAULT false NOT NULL,
                CONSTRAINT pk_reserva PRIMARY KEY (id_reserva)
);
COMMENT ON COLUMN public.reserva.id_pessoa IS 'C�digo da pessoa que fez a reserva, ou, c�digo da pessoa que autorizou a reserva.';
COMMENT ON COLUMN public.reserva.id_autorizador IS 'Pessoa que autorizou a reserva.';
COMMENT ON COLUMN public.reserva.nome_usuario IS 'Campo usado estritamente para pesquisa. O nome do usu�rio � gravado neste campo. Para o caso de importa��es do XML aSc TimeTables, o nome do professor � gravado aqui.';
COMMENT ON COLUMN public.reserva.email_notificacao IS 'E-mail para notifica��o da reserva.';
COMMENT ON COLUMN public.reserva.status IS '[E]fetivada, [C]ancelada ou [P]endente de confirma��o.';
COMMENT ON COLUMN public.reserva.motivo_cancelamento IS 'Motivo do cancelamento quando o status for [C]';
COMMENT ON COLUMN public.reserva.importado IS 'Indica se o registro foi gravado atrav�s de importa��o de XML do aSc TimeTables.';


ALTER SEQUENCE public.reserva_id_reserva_seq OWNED BY public.reserva.id_reserva;

CREATE INDEX ie_reserva_item
 ON public.reserva
 ( id_item_reserva );

CREATE INDEX ie_reserva_pessoa
 ON public.reserva
 ( id_pessoa );

CREATE INDEX ie_reserva_hora
 ON public.reserva
 ( hora_inicio, data, id_campus );

CREATE INDEX ie_reserva_data
 ON public.reserva
 ( data, id_campus );

CREATE INDEX ie_reserva_status_data
 ON public.reserva
 ( status, data, id_campus );

CREATE INDEX ie_reserva_datag
 ON public.reserva
 ( data_gravacao, hora_gravacao, id_campus );

CREATE INDEX ie_reserva_horag
 ON public.reserva
 ( hora_gravacao, data_gravacao, id_campus );

CREATE INDEX ie_reserva_nomeusuario
 ON public.reserva
 ( nome_usuario, id_campus );

CREATE TABLE public.pessoa_grupo_pessoa (
                id_pessoa INTEGER NOT NULL,
                id_grupo_pessoa INTEGER NOT NULL,
                CONSTRAINT pk_pessoa_grupo_pessoa PRIMARY KEY (id_pessoa, id_grupo_pessoa)
);
COMMENT ON TABLE public.pessoa_grupo_pessoa IS 'Relacionamento de pessoas e grupo de pessoas.';


ALTER TABLE public.campus ADD CONSTRAINT fk__instituicao__campus
FOREIGN KEY (id_instituicao)
REFERENCES public.instituicao (id_instituicao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pessoa ADD CONSTRAINT fk__campus__pessoa
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.grupo_pessoa ADD CONSTRAINT fk__campus__grupo_pessoa
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ldap_server ADD CONSTRAINT fk__campus__ldap_server
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.categoria_item_reserva ADD CONSTRAINT fk__campus__categoria_item_reserva
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.professor ADD CONSTRAINT fk__campus__professor
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.transacao ADD CONSTRAINT fk__campus__transacao
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.disciplina ADD CONSTRAINT fk__campus__disciplina
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.periodo_letivo ADD CONSTRAINT fk__campus__periodo_letivo
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.feriado ADD CONSTRAINT fk__campus__feriado
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.item_reserva ADD CONSTRAINT fk__campus__item_reserva
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.classe ADD CONSTRAINT fk__campus__classe
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__campus__reserva
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.timetable ADD CONSTRAINT fk__campus__timetable
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.tipo_reserva ADD CONSTRAINT fk__campus__tipo_reserva
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.mail_server ADD CONSTRAINT fk__campus__mail_server
FOREIGN KEY (id_campus)
REFERENCES public.campus (id_campus)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__tipo_reserva__reserva
FOREIGN KEY (id_tipo_reserva)
REFERENCES public.tipo_reserva (id_tipo_reserva)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.period ADD CONSTRAINT fk__timetable__period
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.subject ADD CONSTRAINT fk__timetable__subject
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.clazz ADD CONSTRAINT fk__timetable__class
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.teacher ADD CONSTRAINT fk__timetable__teacher
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.classroom ADD CONSTRAINT fk__timetable__classroom
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.lesson ADD CONSTRAINT fk__timetable__lesson
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.card ADD CONSTRAINT fk__timetable__card
FOREIGN KEY (id_timetable)
REFERENCES public.timetable (id_timetable)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.professor_pessoa ADD CONSTRAINT fk__professor__professor_pessoa
FOREIGN KEY (id_professor)
REFERENCES public.professor (id_professor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.item_reserva ADD CONSTRAINT fk__categoria_item_reserva__item_reserva
FOREIGN KEY (id_categoria)
REFERENCES public.categoria_item_reserva (id_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__item_reserva__reserva
FOREIGN KEY (id_item_reserva)
REFERENCES public.item_reserva (id_item_reserva)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.autorizacao_item_reserva ADD CONSTRAINT fk__item_reserva__autorizacao_item_reserva
FOREIGN KEY (id_item_reserva)
REFERENCES public.item_reserva (id_item_reserva)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pessoa_grupo_pessoa ADD CONSTRAINT fk__grupo_pessoa__pessoa_grupo_pessoa
FOREIGN KEY (id_grupo_pessoa)
REFERENCES public.grupo_pessoa (id_grupo_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pessoa_grupo_pessoa ADD CONSTRAINT fk__pessoa__grupo_pessoa
FOREIGN KEY (id_pessoa)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__pessoa__reserva
FOREIGN KEY (id_pessoa)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.transacao ADD CONSTRAINT fk__pessoa__transacao
FOREIGN KEY (id_pessoa)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.professor_pessoa ADD CONSTRAINT fk__pessoa__professor_pessoa
FOREIGN KEY (id_pessoa)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__pessoa__reserva_id_usuario
FOREIGN KEY (id_usuario)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.autorizacao_item_reserva ADD CONSTRAINT fk__pessoa__autorizacao_item_reserva
FOREIGN KEY (id_pessoa)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__pessoa__reserva__autorizador
FOREIGN KEY (id_autorizador)
REFERENCES public.pessoa (id_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reserva ADD CONSTRAINT fk__transacao__reserva
FOREIGN KEY (id_transacao)
REFERENCES public.transacao (id_transacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.periodo_letivo ADD CONSTRAINT fk__transacao__periodo_letivo
FOREIGN KEY (id_transacao_reserva)
REFERENCES public.transacao (id_transacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
