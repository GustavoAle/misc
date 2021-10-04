package sistemasdist.trabalho.ejb;

import java.util.List;
import javax.ejb.Remote;
import sistemasdist.trabalho.modelo.Pessoa;
import sistemasdist.trabalho.modelo.Produto;

@Remote
public interface PessoaRemote {
  public Pessoa salvar(Pessoa pessoa) throws Exception;
  public void excluir(Long id) throws Exception;
  public Pessoa consultarPorId(Long id);
  public List<Pessoa> listaDePessoas();
}
