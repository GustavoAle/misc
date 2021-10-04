package sistemasdist.trabalho.ejb;

import java.util.List;
import javax.ejb.Remote;
import sistemasdist.trabalho.modelo.Compra;

@Remote
public interface CompraRemote {
  public Compra salvar(Compra compra) throws Exception;
  public void excluir(Long id);
  public Compra consultarPorId(Long id);
  public List<Compra> listaDeCompras();
}
