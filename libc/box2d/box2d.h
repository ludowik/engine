typedef struct b2Vec2 {
    float xx, yy;
} b2Vec2;

b2Vec2* b2Vec2_new(float x, float y, float ratio);
void b2Vec2_gc(b2Vec2*);

float b2Vec2_x_get(b2Vec2* self);
void b2Vec2_x_set(b2Vec2* self, float x);

float b2Vec2_y_get(b2Vec2* self);
void b2Vec2_y_set(b2Vec2* self, float y);

// World
typedef struct b2World b2World;

b2World* b2World_new();
void b2World_gc(b2World*);

b2Vec2* b2World_getGravity(b2World* world);
void b2World_setGravity(b2World* world, b2Vec2* g);

bool b2World_getContinuous(b2World* world);
void b2World_setContinuous(b2World* world, bool continuous);

void b2World_setAutoClearForces(b2World* self, bool autoClearForces);

void b2World_step(b2World* self, float dt);

void b2World_clearForces(b2World* self);

// Body
typedef struct b2Body b2Body;

// Shape
enum Type {
    e_circle = 0,
    e_edge = 1,
    e_polygon = 2,
    e_chain = 3,
    e_typeCount = 4
};

b2Body* b2Body_new_circle(b2World* world, float radius);
b2Body* b2Body_new_polygon(b2World* world, b2Vec2* points, int n);
b2Body* b2Body_new_chain(b2World* world, b2Vec2* points, int n, bool loop);
b2Body* b2Body_new_edge(b2World* world, b2Vec2* p1, b2Vec2* p2);

void b2Body_gc(b2World* world, b2Body* self);

int b2Body_getId(b2Body* self);

int b2Body_get_type(b2Body* self);
void b2Body_set_type(b2Body* self, int type);

bool b2Body_get_bullet(b2Body* self);
void b2Body_set_bullet(b2Body* self, bool bullet);

int b2Body_get_shape_type(b2Body* self);

b2Vec2* b2Body_get_position(b2Body* self);
void b2Body_set_position(b2Body* self, b2Vec2* position);

bool b2Body_get_sensor(b2Body* self);
void b2Body_set_sensor(b2Body* self, bool sensor);

int b2Body_get_categoryBits(b2Body* self);
void b2Body_set_categoryBits(b2Body* self, int categoryBits);

int b2Body_get_maskBits(b2Body* self);
void b2Body_set_maskBits(b2Body* self, int maskBits);

float b2Body_get_angle(b2Body* self);
void b2Body_set_angle(b2Body* self, float angle);

float b2Body_get_radius(b2Body* self);	
void b2Body_set_radius(b2Body* self, float radius);

float b2Body_get_mass(b2Body* self);	
void b2Body_set_mass(b2Body* self, float mass);

float b2Body_get_density(b2Body* self);	
void b2Body_set_density(b2Body* self, float density);

void b2Body_set_gravityScale(b2Body* self, float gravityScale);
float b2Body_get_gravityScale(b2Body* self);

float b2Body_get_friction(b2Body* self);	
void b2Body_set_friction(b2Body* self, float friction);

bool b2Body_get_fixedRotation(b2Body* self);
void b2Body_set_fixedRotation(b2Body* self, bool fixedRotation);

float b2Body_get_restitution(b2Body* self);	
void b2Body_set_restitution(b2Body* self, float restitution);

bool b2Body_get_sleepingAllowed(b2Body* self);	
void b2Body_set_sleepingAllowed(b2Body* self, bool sleepingAllowed);

b2Vec2* b2Body_get_linearVelocity(b2Body* self);
b2Vec2* b2Body_getLinearVelocityFromWorldPoint(b2Body* self, b2Vec2* anchorPoint);
void b2Body_set_linearVelocity(b2Body* self, b2Vec2* linearVelocity);

float b2Body_get_angularVelocity(b2Body* self);
void b2Body_set_angularVelocity(b2Body* self, float angle);

float b2Body_get_linearDamping(b2Body* self);
void b2Body_set_linearDamping(b2Body* self, float linearDamping);

float b2Body_get_angularDamping(b2Body* self);
void b2Body_set_angularDamping(b2Body* self, float angularDamping);

int b2Body_get_fixture_count(b2Body* self);
int b2Body_get_vertex_count(b2Body* self, int j);
b2Vec2* b2Body_get_vertex(b2Body* self, int j, int i);

void b2Body_setInfo(b2Body* self, void* userdata);
void* b2Body_getInfo(b2Body* self) ;

void b2Body_applyForce(b2Body* self, b2Vec2* force, b2Vec2* worldPoint);
void b2Body_applyForceToCenter(b2Body* self, b2Vec2* force);

void b2Body_applyLinearImpulse(b2Body* self, b2Vec2* force);

void b2Body_applyTorque(b2Body* self, float torque);
void b2Body_applyAngularImpulse(b2Body* self, float impulse);

bool b2Body_testPoint(b2Body* self, b2Vec2* worldPoint);
bool b2Body_testOverlap(b2Body* bodyA, b2Body* bodyB);

b2Vec2* b2Body_getLocalPoint(b2Body* self, b2Vec2* worldPoint);
b2Vec2* b2Body_getWorldPoint(b2Body* self, b2Vec2* localPoint);

// The maximum number of contact points between two convex shapes. Do
// not change this value.

// #define b2_maxManifoldPoints 2

typedef struct ContactPoint {
    int id;
    int state;
    bool touching;
    b2Vec2 position;
    b2Vec2 normal;
    float normalImpulse;
    float tangentImpulse;
    b2Body* bodyA;
    b2Body* bodyB;
    int pointCount;
    b2Vec2 points[2];
} ContactPoint;

typedef void (*collideFunc)(ContactPoint* cp);
void b2World_processContacts(b2World* world, collideFunc func);

// Raycast
typedef struct RaycastResult {
    b2Body* body;
    b2Vec2 point;
    b2Vec2 normal;
    float fraction;
} RaycastResult;

RaycastResult* b2World_raycast(b2World* self, b2Vec2* p1, b2Vec2* p2);
RaycastResult* b2World_raycastAll(b2World* self, b2Vec2* p1, b2Vec2* p2);

b2Body** b2World_queryAABB(b2World* self, b2Vec2* p1, b2Vec2* p2);

// Joint
typedef struct b2Joint b2Joint;

enum b2JointType {
    e_unknownJoint,
    e_revoluteJoint,
    e_prismaticJoint,
    e_distanceJoint,
    e_pulleyJoint,
    e_mouseJoint,
    e_gearJoint,
    e_wheelJoint,
    e_weldJoint,
    e_frictionJoint,
    e_ropeJoint
};

b2Joint* b2Joint_new_revolute (b2World* world, b2Body* bodyA, b2Body* bodyB, b2Vec2* anchor);
b2Joint* b2Joint_new_distance (b2World* world, b2Body* bodyA, b2Body* bodyB, b2Vec2* anchorA, b2Vec2* anchorB);
b2Joint* b2Joint_new_prismatic(b2World* world, b2Body* bodyA, b2Body* bodyB, b2Vec2* anchorA, b2Vec2* direction);
b2Joint* b2Joint_new_weld     (b2World* world, b2Body* bodyA, b2Body* bodyB, b2Vec2* anchorA, b2Vec2* direction);

void b2Joint_gc(b2World* world, b2Joint* joint);

typedef void (*unref)(b2Joint* joint);
void setUnrefJoint(unref func);

b2Vec2* b2Joint_get_anchorA(b2Joint* joint);	
b2Vec2* b2Joint_get_anchorB(b2Joint* joint);

float b2Joint_get_maxMotorTorque(b2Joint* joint_);
void b2Joint_set_maxMotorTorque(b2Joint* joint_, float maxMotorTorque);

bool b2Joint_get_enableMotor(b2Joint* joint_);
void b2Joint_set_enableMotor(b2Joint* joint_, bool enableMotor);

float b2Joint_get_motorSpeed(b2Joint* joint_);
void b2Joint_set_motorSpeed(b2Joint* joint_, float motorSpeed);

bool b2Joint_get_enableLimit(b2Joint* joint_);
void b2Joint_set_enableLimit(b2Joint* joint_, bool enableLimit);

float b2Joint_get_lowerLimit(b2Joint* joint_);
void b2Joint_set_lowerLimit(b2Joint* joint_, float lowerLimit);

float b2Joint_get_upperLimit(b2Joint* joint_);
void b2Joint_set_upperLimit(b2Joint* joint_, float upperLimit);

typedef struct b2Triangle {
    float* x;
    float* y;
} b2Triangle;

int b2World_triangulate(float* trX, float* trY, int n, b2Triangle* triangles);
