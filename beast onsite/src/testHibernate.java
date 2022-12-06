
import java.util.List;
import javax.persistence.*;
import javax.persistence.TypedQuery;


public class testHibernate {

    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence
            .createEntityManagerFactory("beast");
    
            public static void main(String[] args) {
                addUser(1, "John", "Doe", 1, "Johnpass");
                addUser(2, "jane", "Doe", 2, "Janepass");

              
                 deleteUser(2);    	
                ENTITY_MANAGER_FACTORY.close();
            }

            public static void addUser(int userId, String first_name, String last_name, int keyId, String password) {
                // The EntityManager class allows operations such as create, read, update, delete
                EntityManager em = ENTITY_MANAGER_FACTORY.createEntityManager();
                // Used to issue transactions on the EntityManager
                EntityTransaction et = null;
        
                try {
                    // Get transaction and start
                    et = em.getTransaction();
                    et.begin();
        
                    // Create and set values for new customer
                    HUser huser = new HUser();
                    huser.setUserId(userId);
                    huser.setFirstName(first_name);
                    huser.setLastName(last_name);
                    huser.setKeyId(keyId);
                    huser.setPassword(password);
        
                    // Save the customer object
                    em.persist(huser);
                    et.commit();
                } catch (Exception ex) {
                    // If there is an exception rollback changes
                    if (et != null) {
                        et.rollback();
                    }
                    ex.printStackTrace();
                } finally {
                    // Close EntityManager
                    em.close();
                }
            }
            
            public static void getUser(int id) {
                EntityManager em = ENTITY_MANAGER_FACTORY.createEntityManager();
            
                String query = "SELECT u FROM HUser u WHERE u.userId = :userId";
                
                // Issue the query and get a matching Customer
                TypedQuery<HUser> tq = (TypedQuery<HUser>) em.createNativeQuery(query, HUser.class);
                tq.setParameter("userId", id);
                
                HUser user = null;
                try {
                    // Get matching customer object and output
                    user = tq.getSingleResult();
                    System.out.println(user.getFirstName() + " " + user.getLastName());
                }
                catch(NoResultException ex) {
                    ex.printStackTrace();
                }
                finally {
                    em.close();
                }
            }
        
            public static void deleteUser(int id) {
                EntityManager em = ENTITY_MANAGER_FACTORY.createEntityManager();
                EntityTransaction et = null;
                HUser user = null;
        
                try {
                    et = em.getTransaction();
                    et.begin();
                    user = em.find(HUser.class, id);
                    em.remove(user);
                    et.commit();
                } catch (Exception ex) {
                    // If there is an exception rollback changes
                    if (et != null) {
                        et.rollback();
                    }
                    ex.printStackTrace();
                } finally {
                    // Close EntityManager
                    em.close();
                }
        





    
}
}