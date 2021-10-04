package sistemasdist.trabalho.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import sistemasdist.trabalho.modelo.Produto;

public class ProdutoDAO {
  private EntityManager entityManager;

  /***************************************************************************
                          Metodos da Classe
  ***************************************************************************/

  public ProdutoDAO(EntityManager entityManager) {
    this.entityManager = entityManager;
  }

  public Produto salvar(Produto produto) throws Exception{
    System.out.println("Salvando o produto: " + produto.getDescricao());

    if(produto.getId() == null) {
      //id não informado
      this.entityManager.persist(produto);
    } else {
      //id informado
      if(!this.entityManager.contains(produto)) {
        if (entityManager.find(Produto.class, produto.getId()) == null) {
          throw new Exception("Produto não existe!");
        }
      }

      return entityManager.merge(produto); //update
    }
    return produto;
  }

  public void excluir(Long id) throws Exception {
    Produto produto = entityManager.find(Produto.class, id);
/*
    Query query = entityManager.createQuery("SELECT produto_id FROM compra WHERE produto_id = :idproduto");
    query.setParameter("idproduto",id);

    List<Long> resultado = query.getResultList();
    if(resultado.size() != 0){
        throw new Exception("Produto referenciado em compra!");
    }
*/
    System.out.println("Excluindo a produto: " + produto.getDescricao());
    entityManager.remove(produto);
  }

  /**
   * Consulta a pessoa por ID.
   * @param id
   * @return
   */
  public Produto consultarPorId(Long id) {
    return entityManager.find(Produto.class, id);
  }
  
  public List<Produto> listaDeProdutos(){    
    CriteriaBuilder cb = entityManager.getCriteriaBuilder();
    CriteriaQuery<Produto> cq = cb.createQuery(Produto.class);
    Root<Produto> rootEntry = cq.from(Produto.class);
    CriteriaQuery<Produto> all = cq.select(rootEntry);
    TypedQuery<Produto> allQuery = entityManager.createQuery(all);
    
    return allQuery.getResultList();
  }
}
