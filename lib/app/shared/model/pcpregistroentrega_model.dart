class PcpRegistroEntregaModel {
    int id;
    Op op;
    String produzido;
    String obs;
    String prevEntrega;
    String entrega;
    bool cancelada;
    Status status;
    Statusent statusent;

    PcpRegistroEntregaModel(
            {this.id,
                this.op,
                this.produzido,
                this.obs,
                this.prevEntrega,
                this.entrega,
                this.cancelada,
                this.status,
                this.statusent});

    PcpRegistroEntregaModel.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        op = json['op'] != null ? new Op.fromJson(json['op']) : null;
        produzido = json['produzido'];
        obs = json['obs'];
        prevEntrega = json['prev_entrega'];
        entrega = json['entrega'];
        cancelada = json['cancelada'];
        status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
        statusent = json['statusent'] != null
                ? new Statusent.fromJson(json['statusent'])
                : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.op != null) {
            data['op'] = this.op.toJson();
        }
        data['produzido'] = this.produzido;
        data['obs'] = this.obs;
        data['prev_entrega'] = this.prevEntrega;
        data['entrega'] = this.entrega;
        data['cancelada'] = this.cancelada;
        if (this.status != null) {
            data['status'] = this.status.toJson();
        }
        if (this.statusent != null) {
            data['statusent'] = this.statusent.toJson();
        }
        return data;
    }
}

class Op {
    int id;
    int orcamento;
    String cliente;
    String servico;
    String quant;
    String valor;
    String entrada;
    String vendedor;
    int op;

    Op(
            {this.id,
                this.orcamento,
                this.cliente,
                this.servico,
                this.quant,
                this.valor,
                this.entrada,
                this.vendedor,
                this.op});

    Op.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        orcamento = json['orcamento'];
        cliente = json['cliente'];
        servico = json['servico'];
        quant = json['quant'];
        valor = json['valor'];
        entrada = json['entrada'];
        vendedor = json['vendedor'];
        op = json['op'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['orcamento'] = this.orcamento;
        data['cliente'] = this.cliente;
        data['servico'] = this.servico;
        data['quant'] = this.quant;
        data['valor'] = this.valor;
        data['entrada'] = this.entrada;
        data['vendedor'] = this.vendedor;
        data['op'] = this.op;
        return data;
    }
}

class Status {
    int diasp;
    String posicao;

    Status({this.diasp, this.posicao});

    Status.fromJson(Map<String, dynamic> json) {
        diasp = json['diasp'];
        posicao = json['posicao'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['diasp'] = this.diasp;
        data['posicao'] = this.posicao;
        return data;
    }
}

class Statusent {
    int diasat;
    String posicao;

    Statusent({this.diasat, this.posicao});

    Statusent.fromJson(Map<String, dynamic> json) {
        diasat = json['diasat'];
        posicao = json['posicao'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['diasat'] = this.diasat;
        data['posicao'] = this.posicao;
        return data;
    }
}