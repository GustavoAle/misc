package sistemasdist.trabalho.ejb;

import java.util.List;
import javax.ejb.Remote;
import sistemasdist.trabalho.modelo.Produto;

@Remote
public interface ProdutoRemote {
  public Produto salvar(Produto produto) throws Exception;
  public void excluir(Long id) throws Exception;
  public Produto consultarPorId(Long id);
  public List<Produto> listaDeProdutos();
}
