
package Controles.ResponsableGrupo;

import Modelos.Conectar;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

public class ControlEliminarResponsableGrupo {
    
    private JdbcTemplate jdbcTemplate;
    
    public ControlEliminarResponsableGrupo(){
        
        Conectar con=new Conectar();
        this.jdbcTemplate=new JdbcTemplate(con.conectar());
        
    }
    
    @RequestMapping("eliminarresponsablegrupo.htm")
    public ModelAndView responsableGrupo(HttpServletRequest request){
        ModelAndView mav=new ModelAndView();
        int id_responsable=Integer.parseInt(request.getParameter("id_responsable"));
        String sql="select * from responsable_grupo where id_responsable='"+id_responsable+"'";
        List datos=this.jdbcTemplate.queryForList(sql);
        mav.setViewName("eliminarresponsablegrupo");
        mav.addObject("datos",datos);
        return mav;
    }
}
