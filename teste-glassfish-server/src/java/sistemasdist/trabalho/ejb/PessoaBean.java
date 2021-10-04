package sistemasdist.trabalho.ejb;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import sistemasdist.trabalho.dao.PessoaDAO;
import sistemasdist.trabalho.modelo.Pessoa;


@Stateless
public class PessoaBean implements PessoaRemote {
  @PersistenceContext(unitName = "LojaPU")
  private EntityManager em;

  @Override
  public Pessoa salvar(Pessoa pessoa) throws Exception {
    PessoaDAO dao = new PessoaDAO(em);
    return dao.salvar(pessoa);
  }

  @Override
  public void excluir(Long id) throws Exception {
    PessoaDAO dao = new PessoaDAO(em);
    dao.excluir(id);
  }

  @Override
  public Pessoa consultarPorId(Long id) {
    PessoaDAO dao = new PessoaDAO(em);
    return dao.consultarPorId(id);
  }
  
  @Override
  public List<Pessoa> listaDePessoas(){
    PessoaDAO dao = new PessoaDAO(em);
    return dao.listaDePessoas();
  }
 
}
