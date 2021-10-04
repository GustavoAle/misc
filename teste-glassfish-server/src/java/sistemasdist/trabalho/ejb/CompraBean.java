package sistemasdist.trabalho.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import sistemasdist.trabalho.dao.CompraDAO;
import sistemasdist.trabalho.modelo.Compra;

@Stateless
public class CompraBean implements CompraRemote {
  @PersistenceContext(unitName = "LojaPU")
  private EntityManager em;

  @Override
  public Compra salvar(Compra compra) throws Exception {
    CompraDAO dao = new CompraDAO(em);
    return dao.salvar(compra);
  }

  @Override
  public void excluir(Long id) {
    CompraDAO dao = new CompraDAO(em);
    dao.excluir(id);
  }

  @Override
  public Compra consultarPorId(Long id) {
    CompraDAO dao = new CompraDAO(em);
    return dao.consultarPorId(id);
  }
  
@Override
  public List<Compra> listaDeCompras(){
    CompraDAO dao = new CompraDAO(em);
    return dao.listaDeCompras();
  }
}
