
package sistemasdist.trabalho.modelo;

import java.io.Serializable;
import java.util.Date;
//import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;

/**
 *
 * @author ale
 */
@Entity
@Table(name="pessoa")
public class Pessoa implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JoinColumn(nullable = false, name = "id")
    private Long id;

    @JoinColumn(nullable = false, name = "nome")
    private String nome;

    @JoinColumn(nullable = false, name = "data_nasc")
    @Temporal(javax.persistence.TemporalType.DATE)
    private Date data_nasc;

    @JoinColumn(nullable = false, name = "endereco")
    private String endereco;


    /***************************************************************************
                        Metodos da Classe, Set e Gets
    ***************************************************************************/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome(){
      return nome;
    }

    public void setNome(String nome){
      this.nome = nome;
    }

    public String getEndereco(){
      return endereco;
    }

    public void setEndereco(String endereco){
      this.endereco = endereco;
    }

    public Date getDataNascimento(){
      return data_nasc;
    }

    public void setDataNascimento(Date data_nasc){
      this.data_nasc = data_nasc;
    }
}
