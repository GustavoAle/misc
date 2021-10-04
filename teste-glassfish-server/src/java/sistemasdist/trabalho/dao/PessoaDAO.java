package sistemasdist.trabalho.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import sistemasdist.trabalho.modelo.Pessoa;

public class PessoaDAO {
  private EntityManager entityManager;

  /***************************************************************************
                          Metodos da Classe
  ***************************************************************************/

  public PessoaDAO(EntityManager entityManager) {
    this.entityManager = entityManager;
  }

  public Pessoa salvar(Pessoa pessoa) throws Exception{
    System.out.println("Salvando o pessoa: " + pessoa.getNome());

    if(pessoa.getId() == null) {
      //id não informado
      this.entityManager.persist(pessoa);
    } else {
      //id informado
      if(!this.entityManager.contains(pessoa)) {
        if (entityManager.find(Pessoa.class, pessoa.getId()) == null) {
          throw new Exception("Pessoa não existe!");
        }
      }

      return entityManager.merge(pessoa); //update
    }
    return pessoa;
  }

  public void excluir(Long id) throws Exception {
    Pessoa pessoa = entityManager.find(Pessoa.class, id);

    /*
    Query query = entityManager.createQuery("SELECT id FROM compra WHERE pessoa_id = :idpessoa");
    query.setParameter("idpessoa",id);

    List<Pessoa> resultado = query.getResultList();
    if(resultado.size() != 0){
        throw new Exception("Pessoa referenciada em compra!");
    }
*/
    System.out.println("Excluindo a pessoa: " + pessoa.getNome());
    entityManager.remove(pessoa);
  }

  /**
   * Consulta a pessoa por ID.
   * @param id
   * @return
   */
  public Pessoa consultarPorId(Long id) {
    return entityManager.find(Pessoa.class, id);
  }
  
    public List<Pessoa> listaDePessoas(){    
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pessoa> cq = cb.createQuery(Pessoa.class);
        Root<Pessoa> rootEntry = cq.from(Pessoa.class);
        CriteriaQuery<Pessoa> all = cq.select(rootEntry);
        TypedQuery<Pessoa> allQuery = entityManager.createQuery(all);

        return allQuery.getResultList();
    }
}
