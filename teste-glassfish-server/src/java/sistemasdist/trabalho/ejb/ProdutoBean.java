package sistemasdist.trabalho.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import sistemasdist.trabalho.dao.ProdutoDAO;
import sistemasdist.trabalho.modelo.Produto;

@Stateless
public class ProdutoBean implements ProdutoRemote {
  @PersistenceContext(unitName = "LojaPU")
  private EntityManager em;

  @Override
  public Produto salvar(Produto produto) throws Exception {
    ProdutoDAO dao = new ProdutoDAO(em);
    return dao.salvar(produto);
  }

  @Override
  public void excluir(Long id) throws Exception{
    ProdutoDAO dao = new ProdutoDAO(em);
    dao.excluir(id);
  }

  @Override
  public Produto consultarPorId(Long id) {
    ProdutoDAO dao = new ProdutoDAO(em);
    return dao.consultarPorId(id);
  }
  
  @Override
  public List<Produto> listaDeProdutos(){
    ProdutoDAO dao = new ProdutoDAO(em);
    return dao.listaDeProdutos();
  }
}
