#include <btBulletDynamicsCommon.h>
#include <btBulletCollisionCommon.h>
#include <stdio.h>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

extern "C" {
    static btDefaultCollisionConfiguration* collisionConfiguration = NULL;
    static btCollisionDispatcher* dispatcher = NULL;
    static btBroadphaseInterface* overlappingPairCache = NULL;
    static btSequentialImpulseConstraintSolver* solver = NULL;
    static btDiscreteDynamicsWorld* dynamicsWorld = NULL;

    EXPORT btDiscreteDynamicsWorld* world_new() {
        /// collision configuration contains default setup for memory, collision setup. Advanced users can create their own configuration.
        collisionConfiguration = new btDefaultCollisionConfiguration();
        
        if (collisionConfiguration != NULL) {
            /// use the default collision dispatcher. For parallel processing you can use a diffent dispatcher (see Extras / BulletMultiThreaded)
            dispatcher = new btCollisionDispatcher(collisionConfiguration);

            /// the default constraint solver. For parallel processing you can use a different solver (see Extras / BulletMultiThreaded)
            solver = new btSequentialImpulseConstraintSolver();

			/// btDbvtBroadphase is a good general purpose broadphase. You can also try out btAxis3Sweep.
			overlappingPairCache = new btDbvtBroadphase(NULL);
			
			if (dispatcher != NULL &&
                overlappingPairCache != NULL &&
                solver != NULL &&
                collisionConfiguration != NULL)
            {
                dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher,
                    overlappingPairCache,
                    solver,
                    collisionConfiguration);

                dynamicsWorld->setGravity(btVector3(0, -10, 0));
                
                return dynamicsWorld;
            }
        }
        
        return NULL;
    }
    
    EXPORT void world_gc(btDiscreteDynamicsWorld* world) {
        // TODO : crash during release
        return;
        
        // remove the rigidbodies from the dynamics world and delete them
        for (int i = world->getNumCollisionObjects()-1; i >=0; i--) {
            btCollisionObject* obj = world->getCollisionObjectArray()[i];
            btRigidBody* body = btRigidBody::upcast(obj);
            if ( body && body->getMotionState() ) {
                delete body->getMotionState();
            }
            world->removeCollisionObject(obj);
            delete obj;
        }

        // delete collision shapes
        /*for (int j = 0; j<collisionShapes.size() ; j++) {
            btCollisionShape* shape = collisionShapes[j];
            collisionShapes[j] = 0;
            delete shape;
        }*/

        // delete dynamics world
        delete world;

        // delete broadphase
        delete overlappingPairCache;
        
        // delete solver
        delete solver;

        // delete dispatcher
        delete dispatcher;
		
		// delete configuration
        delete collisionConfiguration;

        // next line is optional : it will be cleared by the destructor when the array goes out of scope
        //collisionShapes.clear();
    }
    
    EXPORT void world_step(btDiscreteDynamicsWorld* world, float dt) {
        if (world) {
            world->stepSimulation(dt, 10);
        }
    }
	
	EXPORT btRigidBody* world_body() {
		return NULL;
	}
}
