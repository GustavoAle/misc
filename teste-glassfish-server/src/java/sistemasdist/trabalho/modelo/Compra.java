
package sistemasdist.trabalho.modelo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;

/**
 *
 * @author ale
 */
@Entity
@Table(name="compra")
public class Compra implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JoinColumn(nullable = false, name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(nullable = false, name = "produto_id")
    private Produto produto;

    @ManyToOne
    @JoinColumn(nullable = false, name = "pessoa_id")
    private Pessoa pessoa;

    @JoinColumn(nullable = false, name = "data_venda")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date data_venda;


    /***************************************************************************
                          Metodos da Classe, Set e Gets
    ***************************************************************************/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Pessoa getPessoa(){
      return pessoa;
    }

    public void setPessoa(Pessoa pessoa){
      this.pessoa = pessoa;
    }

    public Produto getProduto(){
      return produto;
    }

    public void setProduto(Produto produto){
      this.produto = produto;
    }

    public Date getDataVenda(){
      return data_venda;
    }

    public void setDataVenda(Date data_venda){
      this.data_venda = data_venda;
    }
}
