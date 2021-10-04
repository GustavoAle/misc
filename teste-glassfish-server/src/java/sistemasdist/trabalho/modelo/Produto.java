
package sistemasdist.trabalho.modelo;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

/**
 *
 * @author ale
 */
@Entity
@Table(name="produto")
public class Produto implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JoinColumn(nullable = false, name = "id")
    private Long id;

    @JoinColumn(nullable = false, name = "descricao")
    private String descricao;

    @JoinColumn(nullable = false, name = "valor")
    private Double valor;

    /***************************************************************************
                          Metodos da Classe, Set e Gets
    ***************************************************************************/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescricao(){
      return descricao;
    }

    public void setDescricao(String descricao){
      this.descricao = descricao;
    }

    public Double getValor(){
      return valor;
    }

    public void setValor(Double valor){
      this.valor = valor;
    }
}
