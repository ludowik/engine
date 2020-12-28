#include <Box2D.h>
#include <ConvexDecomposition/b2Polygon.h>

#include <vector>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

#define CLAMP(x, l, h)  (((x) > (h)) ? (h) : (((x) < (l)) ? (l) : (x)))

extern "C" {
    typedef struct  {
		b2Body* body;
		b2Vec2 point;
		b2Vec2 normal;
		float32 fraction;
	} RaycastResult;

	class RaycastCallback : public b2RayCastCallback {
	public:
		RaycastCallback() {
			m_maskBits = 0;
			m_count = 0;
			results[m_count].body = NULL;
		}
		
		float32 ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float32 fraction) {
			// If filtering is enabled, skip filtered fixtures
			if (m_maskBits != 0 && (fixture->GetFilterData().categoryBits & m_maskBits) == 0) {
				return 1;
			}
			
			results[m_count].body = fixture->GetBody();
			results[m_count].point = point;
			results[m_count].normal = normal;
			results[m_count].fraction = fraction;
			
			m_count++;
			results[m_count].body = NULL;
			
			return fraction;
		}
		
		uint16 m_maskBits;
		uint16 m_count;
		RaycastResult results[100];
	};
	
	class QueryCallback : public b2QueryCallback {
	public:    
		QueryCallback() {
			m_count = 0;
			m_bodies[m_count] = NULL;
		}
		
		bool ReportFixture(b2Fixture* fixture) {
			m_bodies[m_count] = fixture->GetBody();
			
			m_count++;
			m_bodies[m_count] = NULL;
			
			// Return true to continue the query.
			return true;
		}
		
		uint16 m_count;
		b2Body* m_bodies[100];
	};
	
	// contact
	typedef enum ContactState {
		CONTACT_BEGAN=0,
		CONTACT_PERSIST,
		CONTACT_ENDED
	} ContactState;

	struct ContactPoint {
		int ID;
		
		ContactState state;
		
		bool touching;
		
		b2Vec2 position;
		b2Vec2 normal;
		
		float normalImpulse;
		float tangentImpulse;
		
		b2Body* bodyA;
		b2Body* bodyB;
		
		int pointCount;
		b2Vec2 points[b2_maxManifoldPoints];
				
		int ref;
		
		b2Fixture* fixtureA;
		b2Fixture* fixtureB;
		
		int childIndexA;
		int childIndexB;
				
		float normalImpulses[b2_maxManifoldPoints];
		float tangentImpulses[b2_maxManifoldPoints];

		bool operator==(const ContactPoint& other) const {
			return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB) &&
				   (childIndexA == other.childIndexA) && (childIndexB == other.childIndexB);
		}
	};

	class ContactListener : public b2ContactListener {
	public:
		virtual void BeginContact(b2Contact* contact);
		virtual void EndContact(b2Contact* contact);
		
		//virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
		virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
		
		std::vector<ContactPoint> contacts;
		
		int currentID;
	};
	
	void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) {
		b2Fixture* fA = contact->GetFixtureA();
		b2Fixture* fB = contact->GetFixtureB();
		
		ContactPoint temp;
		temp.fixtureA = fA;
		temp.fixtureB = fB;
		temp.childIndexA = contact->GetChildIndexA();
		temp.childIndexB = contact->GetChildIndexB();
		
		// Update existing contact if it exists
		std::vector<ContactPoint>::iterator pos;
		pos = std::find(contacts.begin(), contacts.end(), temp);
		if (pos != contacts.end()) {
			ContactPoint& cp = *pos;
			cp.touching = contact->IsTouching();
			
			b2WorldManifold worldManifold;
			contact->GetWorldManifold(&worldManifold);            
			
			cp.normal = worldManifold.normal;
			cp.position = b2Vec2(0,0);        
			cp.normalImpulse = 0;
			cp.tangentImpulse = 0;
			
			cp.pointCount = contact->GetManifold()->pointCount;
			
			for (int i = 0; i < cp.pointCount ; i++) {
				cp.points[i] = worldManifold.points[i];
				cp.position += worldManifold.points[i];
				cp.normalImpulses[i] = impulse->normalImpulses[i];
				cp.tangentImpulses[i] = impulse->tangentImpulses[i];
				cp.normalImpulse += cp.normalImpulses[i];
				cp.tangentImpulse += cp.tangentImpulses[i];
			}
			
			float inv = (1.0f / cp.pointCount);
			
			cp.position *= inv;
			cp.normalImpulse *= inv;
			cp.tangentImpulse *= inv;        
		}            
	}

	void ContactListener::BeginContact(b2Contact* contact) {
		b2Fixture* fA = contact->GetFixtureA();
		b2Fixture* fB = contact->GetFixtureB();
		
		ContactPoint cp;
		cp.ref = -1;
		cp.ID = currentID++;
		cp.fixtureA = fA;
		cp.fixtureB = fB;
		cp.childIndexA = contact->GetChildIndexA();
		cp.childIndexB = contact->GetChildIndexB();
		cp.state = CONTACT_BEGAN;
		cp.touching = contact->IsTouching();
		
		b2WorldManifold worldManifold;
		contact->GetWorldManifold(&worldManifold);    
		
		cp.normal = worldManifold.normal;
		cp.position = b2Vec2(0,0);
		cp.pointCount = contact->GetManifold()->pointCount;
		for (int i = 0; i < cp.pointCount ; i++) {
			cp.points[i] = worldManifold.points[i];
			cp.position += worldManifold.points[i];
		}
		cp.position *= (1.0f / cp.pointCount);
		
		contacts.push_back(cp);
	}

	void ContactListener::EndContact(b2Contact* contact) {
		b2Fixture* fA = contact->GetFixtureA();
		b2Fixture* fB = contact->GetFixtureB();
		
		ContactPoint cp;
		cp.fixtureA = fA;
		cp.fixtureB = fB;
		cp.childIndexA = contact->GetChildIndexA();
		cp.childIndexB = contact->GetChildIndexB();

		std::vector<ContactPoint>::iterator pos;
		pos = std::find(contacts.begin(), contacts.end(), cp);
		if (pos != contacts.end()) {
			(*pos).state = CONTACT_ENDED;
		}    
	}

	// gravity
	b2Vec2 gravity(0.0f, -10.0f);
		
	int32 velocityIterations = 6;
	int32 positionIterations = 2;

	// Vec2
	EXPORT b2Vec2* b2Vec2_new(float32 x, float32 y) {
		return new b2Vec2(x, y);
	}

	EXPORT void b2Vec2_gc(b2Vec2* self) {
		delete self;
	}

	EXPORT float32 b2Vec2_x_get(b2Vec2* self) {
		return self->x;
	}
		
	EXPORT void b2Vec2_x_set(b2Vec2* self, float32 x) {
		self->x = x;
	}

	EXPORT float32 b2Vec2_y_get(b2Vec2* self) {
		return self->y;
	}
		
	EXPORT void b2Vec2_y_set(b2Vec2* self, float32 y) {
		self->y = y;
	}

	// World
	EXPORT b2World* b2World_new() {
		b2World* world = new b2World(gravity);
		world->SetContinuousPhysics(true);
		world->SetContactListener(new ContactListener());
		return world;
	}

	EXPORT void b2World_gc(b2World* self) {
		delete self;
	}

	EXPORT b2Vec2* b2World_getGravity(b2World* self) {
		return new b2Vec2(self->GetGravity());
	}

	EXPORT void b2World_setGravity(b2World* self, b2Vec2* g) {
		self->SetGravity(*g);
	}
    
    EXPORT void b2World_setContinuous(b2World* self, bool continuous) {
        self->SetContinuousPhysics(continuous);
    }
    
    EXPORT bool b2World_getContinuous(b2World* self) {
        return self->GetContinuousPhysics();
    }    

	EXPORT void b2World_step(b2World* self, float dt) {
		self->Step(dt, velocityIterations, positionIterations);
	}
	
	EXPORT void b2World_clearForces(b2World* self) {
		self->ClearForces();
	}	

	EXPORT void b2World_processContacts(b2World* world, void* collide(ContactPoint* cp)) {
		ContactListener* contactListener = (ContactListener*)world->GetContactManager().m_contactListener;
		
		std::vector<ContactPoint>::iterator iter = contactListener->contacts.begin();
        while (iter != contactListener->contacts.end()) {
            ContactPoint& cp = (*iter);

			cp.bodyA = cp.fixtureA->GetBody();
			cp.bodyB = cp.fixtureB->GetBody();
			
			collide(&cp);
			
            if (cp.state == CONTACT_ENDED) {
                iter = contactListener->contacts.erase(iter);
            } else if (cp.state == CONTACT_BEGAN) {
                cp.state = CONTACT_PERSIST;
                ++iter;
            } else if (cp.state == CONTACT_PERSIST) {
                ++iter;
            } else {
                ++iter;
            }            
        }
	}
	
	EXPORT RaycastResult* b2World_raycast(b2World* self, b2Vec2* p1, b2Vec2* p2) {
		static RaycastCallback callback;
		callback.m_count = 0;
		
		self->RayCast(&callback, *p1, *p2);
		
		if (callback.m_count == 1) {
			return callback.results;
		}
		return NULL;
	}
			
	EXPORT RaycastResult* b2World_raycastAll(b2World* self, b2Vec2* p1, b2Vec2* p2) {
		static RaycastCallback callback;
		callback.m_count = 0;
		
		self->RayCast(&callback, *p1, *p2);
		
		if (callback.m_count > 0) {
			return callback.results;
		}
		return NULL;
	}
	
	EXPORT b2Body** b2World_queryAABB(b2World* self, b2Vec2* p1, b2Vec2* p2) {
        static QueryCallback callback;
		callback.m_count = 0;
		
		b2AABB aabb;
        aabb.lowerBound = *p1;
        aabb.upperBound = *p2;        
        
        self->QueryAABB(&callback, aabb);
		
		return callback.m_bodies;
	}
			
	// Body
	enum {
		CIRCLE   = 0,
		EDGE     = 1,
		POLYGON  = 2,
		CHAIN    = 3,
		COMPOUND = 4
	};

	EXPORT b2Body* b2Body_new(b2World* world, b2BodyType type, b2Shape* shape) {
		b2BodyDef bodyDef;

		bodyDef.type = type;
        
		bodyDef.position.Set(0.0f, 0.0f);
		
		b2Body* body = world->CreateBody(&bodyDef);
				
		b2FixtureDef fixtureDef;
		fixtureDef.shape = shape;
		fixtureDef.density = 1.0f;
		fixtureDef.friction = 0.2f;
        fixtureDef.restitution = 0.2f;
		
		body->CreateFixture(&fixtureDef);
		body->SetSleepingAllowed(true);
        body->SetGravityScale(1.0f);
        
		return body;
	}

	EXPORT b2Body* b2Body_new_circle(b2World* world, float32 radius) {
		b2CircleShape circleShape;
		circleShape.m_p.Set(0.0f, 0.0f);
		circleShape.m_radius = radius;
		
		return b2Body_new(world, b2_dynamicBody, &circleShape);
	}

	EXPORT b2Body* b2Body_new_edge(b2World* world, b2Vec2* p1, b2Vec2* p2) {
		b2EdgeShape edgeShape;
		edgeShape.Set(*p1, *p2);
		
		return b2Body_new(world, b2_staticBody, &edgeShape);
	}

	EXPORT b2Body* b2Body_new_polygon(b2World* world, b2Vec2* points, int n) {
		b2BodyDef bodyDef;
		bodyDef.type = b2_dynamicBody;
		bodyDef.position.Set(0.0f, 0.0f);
		
		b2Body* body = world->CreateBody(&bodyDef);
				
		b2Polygon polygon(points, n);

		if (!polygon.IsCCW()) {
			ReversePolygon(polygon.x, polygon.y, polygon.nVertices);
		}
		
		b2FixtureDef fixtureDef;    
		fixtureDef.density = 1.0f;
		
		DecomposeConvexAndAddTo(&polygon, body, &fixtureDef); 
		
		return body;
	}
	
	EXPORT b2Body* b2Body_new_chain(b2World* world, b2Vec2* points, int n, bool loop) {
		b2BodyDef bodyDef;
		bodyDef.type = b2_staticBody;
		
		// TODO which position
		bodyDef.position.Set(0.0f, 0.0f);
		
		b2Body* body = world->CreateBody(&bodyDef);
						
		b2FixtureDef fixtureDef;    
		fixtureDef.density = 0.0f;
		
		b2ChainShape chainShape;
		fixtureDef.shape = &chainShape;
		if (loop) {
			chainShape.CreateLoop(points, n);
		} else {
			chainShape.CreateChain(points, n);        
		}

		body->CreateFixture(&fixtureDef);
		
		return body;
	}
	
	EXPORT void b2Body_gc(b2Body* self) {
		b2World* world = self->GetWorld();
		world->DestroyBody(self);
	}

	EXPORT long b2Body_getId(b2Body* self) {
		return (long)self;
	}

	EXPORT int b2Body_get_type(b2Body* self) {
		return (int)self->GetType();
	}

	EXPORT void b2Body_set_type(b2Body* self, int type) {
		self->SetType((b2BodyType)type);
	}
    
    EXPORT bool b2Body_get_bullet(b2Body* self) {
		return (int)self->IsBullet();
	}
    
    EXPORT void b2Body_set_bullet(b2Body* self, bool bullet) {
		self->SetBullet(bullet);
	}
	
	EXPORT int b2Body_get_shape_type(b2Body* self) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
            b2Shape* shape = fixture->GetShape();
            return shape->GetType();
        }
        return 0;
	}

	EXPORT b2Vec2* b2Body_get_position(b2Body* self) {
		return new b2Vec2(self->GetPosition());
	}

	EXPORT void b2Body_set_position(b2Body* self, b2Vec2* newPosition) {
		self->SetTransform(*newPosition, self->GetAngle());
	}
    
    EXPORT bool b2Body_get_sensor(b2Body* self) {
        b2Fixture* f = self->GetFixtureList();
        if (f) {
            return f->IsSensor();
        }
        return false;
    }
    
    EXPORT void b2Body_set_sensor(b2Body* self, bool sensor) {
        b2Fixture* f = self->GetFixtureList();
        for (; f; f = f->GetNext()) {
            f->SetSensor(sensor);
		}
	}
    
    EXPORT int b2Body_get_categoryBits(b2Body* self) {
        b2Fixture* f = self->GetFixtureList();
        if (f) {
            return f->GetFilterData().categoryBits;
        }
        return false;
    }
    
    EXPORT void b2Body_set_categoryBits(b2Body* self, int categoryBits) {
        b2Fixture* f = self->GetFixtureList();
        for (; f; f = f->GetNext()) {
            b2Filter filter = f->GetFilterData();
            filter.categoryBits = categoryBits;
            f->SetFilterData(filter);
		}
	}
    
    EXPORT int b2Body_get_maskBits(b2Body* self) {
        b2Fixture* f = self->GetFixtureList();
        if (f) {
            return f->GetFilterData().maskBits;
        }
        return false;
    }
    
    EXPORT void b2Body_set_maskBits(b2Body* self, int maskBits) {
        b2Fixture* f = self->GetFixtureList();
        for (; f; f = f->GetNext()) {
            b2Filter filter = f->GetFilterData();
            filter.maskBits = maskBits;
            f->SetFilterData(filter);
		}
	}
    
	EXPORT float32 b2Body_get_angle(b2Body* self) {
		return self->GetAngle();
	}

	EXPORT void b2Body_set_angle(b2Body* self, float32 angle) {
		self->SetTransform(self->GetPosition(), angle);
	}

	EXPORT float32 b2Body_get_radius(b2Body* self) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			b2Shape* shape = fixture->GetShape();
            return shape->m_radius;
        }
        return 0;
	}

	EXPORT void b2Body_set_radius(b2Body* self, float32 radius) {
		b2Fixture* fixture = self->GetFixtureList();
		if (fixture) {
			b2Shape* shape = fixture->GetShape();
			shape->m_radius = radius;
		}
	}

	EXPORT float32 b2Body_get_mass(b2Body* self) {
		return self->GetMass();
	}

	EXPORT void b2Body_set_mass(b2Body* self, float32 mass) {
        mass = CLAMP(mass, 0, b2_maxFloat);
        b2MassData massData;
        self->GetMassData(&massData);
        massData.mass = mass;
        self->SetMassData(&massData);
	}
	
	EXPORT b2Vec2* b2Body_get_linearVelocity(b2Body* self) {
		return new b2Vec2(self->GetLinearVelocity());
	}

	EXPORT b2Vec2* b2Body_getLinearVelocityFromWorldPoint(b2Body* self, b2Vec2* anchorPoint) {
		return new b2Vec2(self->GetLinearVelocityFromWorldPoint(*anchorPoint));
	}

	EXPORT void b2Body_set_linearVelocity(b2Body* self, b2Vec2* linearVelocity) {
		self->SetLinearVelocity(*linearVelocity);
	}

	EXPORT float32 b2Body_get_angularVelocity(b2Body* self) {
		return self->GetAngularVelocity();
	}

	EXPORT void b2Body_set_angularVelocity(b2Body* self, float32 angle) {
		self->SetAngularVelocity(angle);
	}
    
    EXPORT float32 b2Body_get_linearDamping(b2Body* self) {
		return self->GetLinearDamping();
	}

	EXPORT void b2Body_set_linearDamping(b2Body* self, float32 linearDamping) {
		self->SetLinearDamping(linearDamping);
	}
    
    EXPORT float32 b2Body_get_angularDamping(b2Body* self) {
		return self->GetAngularDamping();
	}

	EXPORT void b2Body_set_angularDamping(b2Body* self, float32 angularDamping) {
		self->SetAngularDamping(angularDamping);
	}

	EXPORT float32 b2Body_get_friction(b2Body* self) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			return fixture->GetFriction();
		}
		return 0.;
	}

	EXPORT void b2Body_set_friction(b2Body* self, float32 friction) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			fixture->SetFriction(friction);
		}
	}
    
    EXPORT bool b2Body_get_fixedRotation(b2Body* self) {
        return self->IsFixedRotation();
    }
	
    EXPORT void b2Body_set_fixedRotation(b2Body* self, bool fixedRotation) {
        self->SetFixedRotation(fixedRotation);
    }
	
    EXPORT float32 b2Body_get_density(b2Body* self) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			return fixture->GetDensity();
		}
		return 0.;
	}

	EXPORT void b2Body_set_density(b2Body* self, float32 density) {
        b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			fixture->SetDensity(density);
		}
	}

	EXPORT void b2Body_set_gravityScale(b2Body* self, float32 gravityScale) {
        self->SetGravityScale(gravityScale);
	}

	EXPORT float32 b2Body_get_gravityScale(b2Body* self) {
        return self->GetGravityScale();
	}

	EXPORT float32 b2Body_get_restitution(b2Body* self) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			return fixture->GetRestitution();
		}
		return 0.;
	}

	EXPORT void b2Body_set_restitution(b2Body* self, float32 restitution) {
		b2Fixture* fixture = self->GetFixtureList();
        if (fixture) {
			fixture->SetRestitution(restitution);
		}
	}

	EXPORT bool b2Body_get_sleepingAllowed(b2Body* self) {
		return self->IsSleepingAllowed();
	}
	
	EXPORT void b2Body_set_sleepingAllowed(b2Body* self, bool sleepingAllowed) {
			self->SetSleepingAllowed(sleepingAllowed);
	}
		
	EXPORT int b2Body_get_fixture_count(b2Body* self) {
        int count = 0;
        b2Fixture* f = self->GetFixtureList();
        for (; f; count++, f = f->GetNext()) {
		}
		return count;
    }
    
	EXPORT int b2Body_get_vertex_count(b2Body* self, int j) {
        int count = 0;
        b2Fixture* f = self->GetFixtureList();
        for (; f && count < j; count++, f = f->GetNext()) {
        }
        
        if (f) {
            b2Shape* shape = (b2Shape*)f->GetShape();
            if (shape->m_type == b2Shape::e_polygon) {
                b2PolygonShape* polygonShape = (b2PolygonShape*)shape;
                return polygonShape->GetVertexCount();
            } else if (shape->m_type == b2Shape::e_edge)  {
                return 2;
            }
        }
		return 0;
	}

	EXPORT b2Vec2* b2Body_get_vertex(b2Body* self, int j, int i) {
        int count = 0;
        b2Fixture* f = self->GetFixtureList();
        for (; f && count < j; count++, f = f->GetNext()) {
        }
        
        if (f) {
            b2Shape* shape = (b2Shape*)f->GetShape();
            if (shape->m_type == b2Shape::e_polygon) {
                static b2Vec2 vertex;
                b2PolygonShape* polygonShape = (b2PolygonShape*)shape;
                vertex = polygonShape->GetVertex(i);
                return &vertex;
            } else if (shape->m_type == b2Shape::e_edge)  {
                b2EdgeShape* edgeShape = (b2EdgeShape*)shape;
                if (i == 0)
                    return &edgeShape->m_vertex1;
                else if (i == 1)
                    return &edgeShape->m_vertex2;
            }
        }
		return NULL;
	}

	EXPORT void b2Body_setInfo(b2Body* self, void* userdata) {
		self->SetUserData(userdata);
	}

	EXPORT void* b2Body_getInfo(b2Body* self) {
		return self->GetUserData();
	}
	
	EXPORT void b2Body_applyForce(b2Body* self, b2Vec2* force) {
		self->ApplyForceToCenter(*force, true);
	}
	
	EXPORT void b2Body_applyLinearImpulse(b2Body* self, b2Vec2* force) {
        b2Vec2 center = self->GetPosition();
		self->ApplyLinearImpulse(*force, center, true);
	}
	
	EXPORT bool b2Body_testPoint(b2Body* self, b2Vec2* worldPoint) {
		bool test = false;
		for (b2Fixture* f = self->GetFixtureList(); f; f = f->GetNext()) {
			if (f->TestPoint(*worldPoint)) {
				test = true;
				break;
			}
		}
		
		return test;
	}

	EXPORT bool b2Body_testOverlap(b2Body* bodyA, b2Body* bodyB) {
		bool test = false;
		for (b2Fixture* fA = bodyA->GetFixtureList(); fA; fA = fA->GetNext()) {
			for (b2Fixture* fB = bodyB->GetFixtureList(); fB; fB = fB->GetNext()) {
				if (b2TestOverlap(fA->GetShape(), 0, fB->GetShape(), 0, bodyA->GetTransform(), bodyB->GetTransform())) {
					test = true;
					break;
				}
			}             
			if (test) {
				break;
			}
		}
		
		return test;
	}

	EXPORT b2Vec2* b2Body_getLocalPoint(b2Body* self, b2Vec2* worldPoint) {
		b2Vec2 localPoint;
		
		/*if (poly->interpolate) {
			b2Transform tx;
			tx.Set(b2Vec2(poly->renderX, poly->renderY), poly->renderAngle);
			localPoint = b2MulT(tx, worldPoint);
		}
		else*/ {
			localPoint = self->GetLocalPoint(*worldPoint);
		}
		
		return new b2Vec2(localPoint);
	}

	EXPORT b2Vec2* b2Body_getWorldPoint(b2Body* self, b2Vec2* localPoint) {
		b2Vec2 worldPoint;
		
		/*if (poly->interpolate) {
			b2Transform tx;
			tx.Set(b2Vec2(poly->renderX, poly->renderY), poly->renderAngle);
			worldPoint = b2Mul(tx, localPoint);
		}
		else */ {
			worldPoint = self->GetWorldPoint(*localPoint);
		}
		
		return new b2Vec2(worldPoint);
	}
	
	EXPORT b2Joint* b2Joint_new_revolute(b2World* world,
        b2Body* bodyA, b2Body* bodyB,
        b2Vec2* anchor)
    {
		b2RevoluteJointDef jointDef;
		jointDef.Initialize(bodyA, bodyB, *anchor);
		
		b2Joint* joint = (b2Joint*)world->CreateJoint(&jointDef);
		return joint;
	}

	EXPORT b2Joint* b2Joint_new_distance(b2World* world,
        b2Body* bodyA, b2Body* bodyB,
        b2Vec2* anchorA, b2Vec2* anchorB)
    {
		b2DistanceJointDef jointDef;
		jointDef.Initialize(bodyA, bodyB, *anchorA, *anchorB);
		
		b2Joint* joint = (b2Joint*)world->CreateJoint(&jointDef);
		return joint;
	}
	
	EXPORT b2Joint* b2Joint_new_prismatic(b2World* world,
        b2Body* bodyA, b2Body* bodyB,
        b2Vec2* anchor, b2Vec2* direction)
    {
		b2PrismaticJointDef jointDef;
		jointDef.Initialize(bodyA, bodyB, *anchor, *direction);
		
		b2Joint* joint = (b2Joint*)world->CreateJoint(&jointDef);
		return joint;
	}
    
    EXPORT b2Joint* b2Joint_new_weld(b2World* world,
        b2Body* bodyA, b2Body* bodyB,
        b2Vec2* anchor)
    {
		b2WeldJointDef jointDef;
		jointDef.Initialize(bodyA, bodyB, *anchor);
		
		b2Joint* joint = (b2Joint*)world->CreateJoint(&jointDef);
		return joint;
	}

	EXPORT void b2Joint_gc(b2Joint* self) {
		b2World* world = self->GetBodyA()->GetWorld();
		world->DestroyJoint(self);
	}
	
	EXPORT b2Vec2* b2Joint_get_anchorA(b2Joint* joint) {
		return new b2Vec2(joint->GetAnchorA());
	}
	
	EXPORT b2Vec2* b2Joint_get_anchorB(b2Joint* joint) {
		return new b2Vec2(joint->GetAnchorB());
	}
    
    EXPORT float32 b2Joint_get_maxMotorTorque(b2Joint* joint_) {
        b2RevoluteJoint* joint = (b2RevoluteJoint*)joint_;
        return joint->GetMaxMotorTorque();
    }
    
    EXPORT void b2Joint_set_maxMotorTorque(b2Joint* joint_, float32 maxMotorTorque) {
        b2RevoluteJoint* joint = (b2RevoluteJoint*)joint_;
        joint->SetMaxMotorTorque(maxMotorTorque);
    }
    
    EXPORT bool b2Joint_get_enableMotor(b2Joint* joint_) {
        b2RevoluteJoint* joint = (b2RevoluteJoint*)joint_;
        return joint->IsMotorEnabled();
    }
    
    EXPORT void b2Joint_set_enableMotor(b2Joint* joint_, bool enableMotor) {
        b2RevoluteJoint* joint = (b2RevoluteJoint*)joint_;
        joint->EnableMotor(enableMotor);
    }
    
    EXPORT float32 b2Joint_get_motorSpeed(b2Joint* joint_) {
        b2RevoluteJoint* joint = (b2RevoluteJoint*)joint_;
        return joint->GetMotorSpeed();
    }
    
    EXPORT void b2Joint_set_motorSpeed(b2Joint* joint_, float32 motorSpeed) {
        b2RevoluteJoint* joint = (b2RevoluteJoint*)joint_;
        joint->SetMotorSpeed(motorSpeed);
    }
	
	EXPORT bool b2Joint_get_enableLimit(b2Joint* joint_) {
        b2PrismaticJoint* joint = (b2PrismaticJoint*)joint_;
        return joint->IsLimitEnabled();
    }
    
    EXPORT void b2Joint_set_enableLimit(b2Joint* joint_, bool enableLimit) {
        b2PrismaticJoint* joint = (b2PrismaticJoint*)joint_;
        joint->EnableLimit(enableLimit);
    }
	
	EXPORT float32 b2Joint_get_lowerLimit(b2Joint* joint_) {
        b2PrismaticJoint* joint = (b2PrismaticJoint*)joint_;
        return joint->GetLowerLimit();
    }
    
    EXPORT void b2Joint_set_lowerLimit(b2Joint* joint_, float32 lowerLimit) {
        b2PrismaticJoint* joint = (b2PrismaticJoint*)joint_;
        joint->SetLimits(lowerLimit, joint->GetUpperLimit());
    }
	
	EXPORT float32 b2Joint_get_upperLimit(b2Joint* joint_) {
        b2PrismaticJoint* joint = (b2PrismaticJoint*)joint_;
        return joint->GetUpperLimit();
    }
    
    EXPORT void b2Joint_set_upperLimit(b2Joint* joint_, float32 upperLimit) {
        b2PrismaticJoint* joint = (b2PrismaticJoint*)joint_;
        joint->SetLimits(joint->GetLowerLimit(), upperLimit);
    }
	
	EXPORT int b2World_triangulate(float* trX, float* trY, int n, b2Triangle* triangles) {
		return TriangulatePolygon(trX, trY, n, triangles);
	}
}
