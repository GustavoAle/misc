package sistemasdist.trabalho.modelo;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import sistemasdist.trabalho.modelo.Pessoa;
import sistemasdist.trabalho.modelo.Produto;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-08-25T20:20:37")
@StaticMetamodel(Compra.class)
public class Compra_ { 

    public static volatile SingularAttribute<Compra, Pessoa> pessoa;
    public static volatile SingularAttribute<Compra, Produto> produto;
    public static volatile SingularAttribute<Compra, Date> data_venda;
    public static volatile SingularAttribute<Compra, Long> id;

}