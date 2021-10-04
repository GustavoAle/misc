package sistemasdist.trabalho.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import sistemasdist.trabalho.modelo.Compra;

public class CompraDAO {
  private EntityManager entityManager;

  /***************************************************************************
                          Metodos da Classe
  ***************************************************************************/

  public CompraDAO(EntityManager entityManager) {
    this.entityManager = entityManager;
  }

  public Compra salvar(Compra compra) throws Exception{
    System.out.println("Salvando a compra: " + compra.getId());

    if(compra.getId() == null) {
      //id não informado
      this.entityManager.persist(compra);
    } else {
      //id informado
      if(!this.entityManager.contains(compra)) {
        if (entityManager.find(Compra.class, compra.getId()) == null) {
          throw new Exception("Compra não existe!");
        }
      }

      return entityManager.merge(compra); //update
    }
    return compra;
  }

  public void excluir(Long id) {
    Compra compra = entityManager.find(Compra.class, id);
    System.out.println("Excluindo a Compra: " + compra.getId());
    entityManager.remove(compra);
  }

  public Compra consultarPorId(Long id) {
    return entityManager.find(Compra.class, id);
  }
  
      public List<Compra> listaDeCompras(){    
          
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Compra> cq = cb.createQuery(Compra.class);
        Root<Compra> rootEntry = cq.from(Compra.class);
        CriteriaQuery<Compra> all = cq.select(rootEntry);
        TypedQuery<Compra> allQuery = entityManager.createQuery(all);

        return allQuery.getResultList();
    }
}
