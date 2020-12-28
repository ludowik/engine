ffi.cdef[[
	typedef struct b2Vec2 {
		float xx, yy;
	} b2Vec2;
	
	b2Vec2* b2Vec2_new(float x, float y);
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
	void b2Body_gc(b2Body* self);
	
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
	
	void b2Body_applyForce(b2Body* self, b2Vec2* force);
    void b2Body_applyLinearImpulse(b2Body* self, b2Vec2* force);
	
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
    
	void b2Joint_gc(b2Joint* joint);
	
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
]]

local b2World
if osx then
    b2World = ffi.load(osLibPath..'/bin/'..osLibDir..'/box2d.so')
else
    b2World = ffi.load(osLibPath..'/bin/'..osLibDir..'/box2d.dll')
end

local physics

local pixelToMeterRatio = 32
local mtpRatio = pixelToMeterRatio
local ptmRatio = 1 / mtpRatio

function newPhysics()
    physics = ffi.gc(b2World.b2World_new(), b2World.b2World_gc)
    physics.running = true
    
    -- TODO
    Gravity = physics.gravity()
    return physics
end

local accum = 0

local userdata = {}

CIRCLE   = b2World.e_circle
EDGE     = b2World.e_edge
POLYGON  = b2World.e_polygon
CHAIN    = b2World.e_chain
COMPOUND = b2World.e_typeCount

STATIC    = 0 -- b2World.b2_staticBody
KINEMATIC = 1 -- b2World.b2_kinematicBody
DYNAMIC   = 2 -- b2World.b2_dynamicBody

REVOLUTE  = b2World.e_revoluteJoint
PRISMATIC = 1
DISTANCE  = 2
WELD      = 3
ROPE      = 4

BEGAN = 0
MOVING = 1
ENDED = 2

local function b2Vec2(x, y)
    return ffi.gc(b2World.b2Vec2_new(x, y), b2World.b2Vec2_gc)
end

local b2Vec2_mt = ffi.metatype('b2Vec2', {
        __newindex = function (tbl, key, value)
            if key == 'x' then
                b2World.b2Vec2_x_set(tbl, value)
            elseif key == 'y' then
                b2World.b2Vec2_y_set(tbl, value)
            else
                rawset(b2Vec2_index, key, value)
            end
        end,

        __index = function (tbl, key)
            if key == 'x' then
                return b2World.b2Vec2_x_get(tbl)
            elseif key == 'y' then
                return b2World.b2Vec2_y_get(tbl)
            else
                return rawget(b2Vec2_index, key)
            end
        end,

        __tostring = function (tbl)
            return '('..string.format('%.2f', tbl.x)..','..string.format('%.2f', tbl.y)..')'
        end
    })

local function collideFunc(cp)
    local contact = {
        id = cp.id,
        state = cp.state,
        touching = cp.touching,
        position = vec3(cp.position.x*mtpRatio, cp.position.y*mtpRatio),
        normal = vec3(cp.normal.x, cp.normal.y),
        normalImpulse = cp.normalImpulse,
        tangentImpulse = cp.tangentImpulse,
        pointCount = cp.pointCount,
        points = {},
        bodyA = cp.bodyA,
        bodyB = cp.bodyB
    }

    for i=1,cp.pointCount do
        table.add(contact.points,
            vec3(cp.points[i-1].x*mtpRatio, cp.points[i-1].y*mtpRatio))
    end

    if engine.collide then
        engine.collide(contact)

        if contact.state ~= ENDED then
            physics.contacts:add(contact)
        end
    end
end

local function __triangulate(points)
    local x = ffi.new('float[2048]')
    local y = ffi.new('float[2048]')

    local triangles = ffi.new('b2Triangle[4096]')

    for i,point in ipairs(points) do
        x[i-1] = point.x
        y[i-1] = point.y
    end

    local triCount = b2World.b2World_triangulate(x, y, #points, triangles)

    local vertices = Table()
    for i=1,triCount do
        local v = triangles[i]
        vertices:add(vec3(v.x[i-1], v.y[i-1]))
    end

    return vertices
end

local b2World_index = {
    gravity = function (x, y)
        if x == nil and y == nil then
            local g = b2World.b2World_getGravity(physics)
            return vec3(g.x, g.y)
        else
            if x and y then
                b2World.b2World_setGravity(physics, b2Vec2(x, y))
            elseif x.x then
                local g = x
                b2World.b2World_setGravity(physics, b2Vec2(g.x, g.y))
            end
        end
    end,

    update = function (dt)
        physics.contacts = Table()
        if physics.running then
            local timeStep = 1. / config.framerate

            accum = accum + dt

            while (accum >= timeStep) do
                accum = accum - timeStep

                b2World.b2World_step(physics, dt)

                -- clear forces
                b2World.b2World_clearForces(physics)

                -- process contact
                local collideFunc = ffi.cast('collideFunc', collideFunc)
                b2World.b2World_processContacts(physics, collideFunc)
                collideFunc:free()
            end
        end
    end,

    draw = function ()
        noStroke()
        fill(red)
        circleMode(CENTER)
        for _,contact in ipairs(physics.contacts) do
            for i=1,contact.pointCount do
                local point = contact.points[i]
                circle(point.x, point.y, 5)
            end
        end
    end,

    pause = function ()
        physics.running = false
    end,

    resume = function ()
        physics.running = true
    end,

    clear = function ()
        functionNotImplemented('physics.clear')
    end,

    edge = function ()
        functionNotImplemented('physics.edge')
    end,

    joint = function ()
        functionNotImplemented('physics.joint')
    end,

    body = function (shapeType, ...)
        local self = physics

        local args = {...}

        if shapeType == CIRCLE then
            local radius = args[1] or 5
            return b2World.b2Body_new_circle(self, radius*ptmRatio)

        elseif shapeType == EDGE then
            local p1 = b2Vec2(args[1].x*ptmRatio, args[1].y*ptmRatio)
            local p2 = b2Vec2(args[2].x*ptmRatio, args[2].y*ptmRatio)
            return b2World.b2Body_new_edge(self, p1, p2)

        elseif shapeType == POLYGON then
            args = args[1].x and args or args[1]

            local points = ffi.new('b2Vec2[?]', #args)
            for i=1,#args do
                points[i-1].x = args[i].x*ptmRatio
                points[i-1].y = args[i].y*ptmRatio
            end
            return b2World.b2Body_new_polygon(self, points, #args)

        elseif shapeType == CHAIN then
            local loop = table.remove(args, 1) or true
            args = args[1].x and args or args[1]

            local points = ffi.new('b2Vec2[?]', #args)
            for i=1,#args do
                points[i-1].x = args[i].x*ptmRatio
                points[i-1].y = args[i].y*ptmRatio
            end
            return b2World.b2Body_new_chain(self, points, #args, loop)
        end

        return b2World.b2Body_new_circle(self, 1)
    end,

    raycast = function (p1, p2)
        local self = physics

        local result = b2World.b2World_raycast(self, 
            b2Vec2(p1.x*ptmRatio, p1.y*ptmRatio),
            b2Vec2(p2.x*ptmRatio, p2.y*ptmRatio))

        if result ~= NULL then
            return {
                body = result.body,
                point = vec3(result.point.x*mtpRatio, result.point.y*mtpRatio),
                normal = vec3(result.normal.x, result.normal.y),
                fraction = result.fraction
            }
        end
    end,

    raycastAll = function (p1, p2)
        local self = physics

        local result = b2World.b2World_raycastAll(self, 
            b2Vec2(p1.x*ptmRatio, p1.y*ptmRatio),
            b2Vec2(p2.x*ptmRatio, p2.y*ptmRatio))

        local bodies = {}
        if result ~= NULL then
            local i = 0
            while (result[i].body ~= NULL) do
                table.add(bodies, {
                        body = result[i].body,
                        point = vec3(result[i].point.x*mtpRatio, result[i].point.y*mtpRatio),
                        normal = vec3(result[i].normal.x, result[i].normal.y),
                        fraction = result[i].fraction
                    })
                i = i + 1
            end
        end
        return bodies
    end,

    queryAABB = function (p1, p2)
        local self = physics

        local result = b2World.b2World_queryAABB(self,
            b2Vec2(p1.x*ptmRatio, p1.y*ptmRatio),
            b2Vec2(p2.x*ptmRatio, p2.y*ptmRatio))

        if result then
            local bodies = {}
            local i = 0
            while (result[i] ~= NULL) do
                table.add(bodies, result[i])
                i = i + 1
            end
            return bodies
        end
    end,

    joint = function (jointType, bodyA, bodyB, anchorA, anchorB, maxLength)
        local self = physics

        local direction = anchorB
        anchorB = anchorB or vec3()

        anchorA = b2Vec2(anchorA.x*ptmRatio, anchorA.y*ptmRatio)
        anchorB = b2Vec2(anchorB.x*ptmRatio, anchorB.y*ptmRatio)

        maxLength = maxLength or 0

        if jointType == REVOLUTE then
            return b2World.b2Joint_new_revolute(self, bodyA, bodyB, anchorA)
        elseif jointType == DISTANCE then
            return b2World.b2Joint_new_distance(self, bodyA, bodyB, anchorA, anchorB)
        elseif jointType == PRISMATIC then
            return b2World.b2Joint_new_prismatic(self, bodyA, bodyB, anchorA, direction)
        elseif jointType == WELD then
            return b2World.b2Joint_new_weld(self, bodyA, bodyB, anchorA, direction)
        else
            assert()
        end
    end,

    triangulate = triangulate
}

local b2World_mt = ffi.metatype('b2World', {
        __newindex = function (tbl, key, value)
            if key == 'continuous' then
                b2World.b2World_setContinuous(tbl, value)
            elseif key == 'pixelToMeterRatio' then
                pixelToMeterRatio = value
                mtpRatio = pixelToMeterRatio
                ptmRatio = 1 / mtpRatio
            else
                rawset(b2World_index, key, value)
            end
        end,

        __index = function (tbl, key)
            if key == 'continuous' then
                return b2World.b2World_getContinuous(tbl)
            elseif key == 'pixelToMeterRatio' then
                return pixelToMeterRatio
            else
                return rawget(b2World_index, key)
            end
        end
    })

local b2Body_index = {
    destroy = b2World.b2Body_gc,

    applyForce = function (self, force)
        b2World.b2Body_applyForce(self, b2Vec2(force.x*ptmRatio, force.y*ptmRatio))
    end,

    applyLinearImpulse = function (self, force)
        b2World.b2Body_applyLinearImpulse(self, b2Vec2(force.x*ptmRatio, force.y*ptmRatio))
    end,

    testPoint = function (self, worldPoint)
        return b2World.b2Body_testPoint(self, b2Vec2(worldPoint.x*ptmRatio, worldPoint.y*ptmRatio))
    end,

    testOverlap = function (self, otherBody)
        return b2World.b2Body_testOverlap(self, otherBody)
    end,

    getLocalPoint = function (self, worldPoint)
        local localPoint = b2World.b2Body_getLocalPoint(self, b2Vec2(worldPoint.x*ptmRatio, worldPoint.y*ptmRatio))
        return vec3(localPoint.x*mtpRatio, localPoint.y*mtpRatio)
    end,

    getWorldPoint = function (self, localPoint)
        local worldPoint = b2World.b2Body_getWorldPoint(self, b2Vec2(localPoint.x*ptmRatio, localPoint.y*ptmRatio))
        return vec3(worldPoint.x*mtpRatio, worldPoint.y*mtpRatio)
    end,

    getLinearVelocityFromWorldPoint = function (self, worldPoint)
        local velocity = b2World.b2Body_getLinearVelocityFromWorldPoint(self, b2Vec2(worldPoint.x*ptmRatio, worldPoint.y*ptmRatio))
        return vec3(velocity.x*mtpRatio, velocity.y*mtpRatio)
    end,

    -- TODEL
--    getPosition = function(self)
--        local position = self.position
--        return position.x, position.y
--    end,

--    getAngle = function(self)
--        return self.angle
--    end
}

local b2Body_mt = ffi.metatype('b2Body', {
        __newindex = function (tbl, key, value)
            if key == 'type' then
                b2World.b2Body_set_type(tbl, value)
            elseif key == 'bullet' then
                b2World.b2Body_set_bullet(tbl, value)
            elseif key == 'position' then
                b2World.b2Body_set_position(tbl, b2Vec2(value.x*ptmRatio, value.y*ptmRatio))
            elseif key == 'sensor' then
                b2World.b2Body_set_sensor(tbl, value)
            elseif key == 'x' then
                local position = b2World.b2Body_get_position(tbl)
                b2World.b2Body_set_position(tbl, b2Vec2(value*ptmRatio, position.y))
            elseif key == 'y' then
                local position = b2World.b2Body_get_position(tbl)
                b2World.b2Body_set_position(tbl, b2Vec2(position.x, value*ptmRatio))
            elseif key == 'angle' then
                b2World.b2Body_set_angle(tbl, rad(value))
            elseif key == 'radius' then
                b2World.b2Body_set_radius(tbl, value*ptmRatio)
            elseif key == 'mass' then
                b2World.b2Body_set_mass(tbl, value)
            elseif key == 'density' then
                b2World.b2Body_set_density(tbl, value)
            elseif key == 'gravityScale' then
                b2World.b2Body_set_gravityScale(tbl, value)
            elseif key == 'friction' then
                b2World.b2Body_set_friction(tbl, value)
            elseif key == 'fixedRotation' then
                b2World.b2Body_set_fixedRotation(tbl, value)
            elseif key == 'restitution' then
                b2World.b2Body_set_restitution(tbl, value)
            elseif key == "linearVelocity" then
                b2World.b2Body_set_linearVelocity(tbl, b2Vec2(value.x*ptmRatio, value.y*ptmRatio))
            elseif key == "angularVelocity" then
                b2World.b2Body_set_angularVelocity(tbl, rad(value))
            elseif key == "linearDamping" then
                b2World.b2Body_set_linearDamping(tbl, value)
            elseif key == "angularDamping" then
                b2World.b2Body_set_angularDamping(tbl, value)
            elseif key == 'interpolate' then
                -- TODO
                -- b2World.b2Body_set_interpolate(value)
            elseif key == 'sleepingAllowed' then
                b2World.b2Body_set_sleepingAllowed(tbl, value)
            elseif key == 'categories' then
                local categoryBits = 0
                for i,category in ipairs(value) do
                    categoryBits = categoryBits + 2^category
                end
                b2World.b2Body_set_categoryBits(tbl, categoryBits)
            elseif key == 'mask' then
                local maskBits = 0
                for i,mask in ipairs(value) do
                    maskBits = maskBits + 2^mask
                end
                b2World.b2Body_set_maskBits(tbl, maskBits)
            elseif key == 'info' then
                userdata[b2World.b2Body_getId(tbl)] = value
            else
                rawset(b2Body_index, key, value)
            end
        end,

        __index = function (tbl, key)
            if key == 'type' then
                return b2World.b2Body_get_type(tbl)
            elseif key == 'bullet' then
                return b2World.b2Body_get_bullet(tbl)
            elseif key == 'shapeType' then
                return b2World.b2Body_get_shape_type(tbl)
            elseif key == 'position' then
                local position = b2World.b2Body_get_position(tbl)
                return vec3(position.x*mtpRatio, position.y*mtpRatio)
            elseif key == 'sensor' then
                return b2World.b2Body_get_sensor(tbl)
            elseif key == 'x' then
                local position = b2World.b2Body_get_position(tbl)
                return position.x*mtpRatio
            elseif key == 'y' then
                local position = b2World.b2Body_get_position(tbl)
                return position.y*mtpRatio
            elseif key == 'angle' then
                return deg(b2World.b2Body_get_angle(tbl))
            elseif key == 'radius' then
                return b2World.b2Body_get_radius(tbl)*mtpRatio
            elseif key == 'mass' then
                return b2World.b2Body_get_mass(tbl)
            elseif key == 'density' then
                return b2World.b2Body_get_density(tbl)
            elseif key == 'gravityScale' then
                return b2World.b2Body_get_gravityScale(tbl)
            elseif key == 'friction' then
                return b2World.b2Body_get_friction(tbl)
            elseif key == 'fixedRotation' then
                return b2World.b2Body_get_fixedRotation(tbl)
            elseif key == 'restitution' then
                return b2World.b2Body_get_restitution(tbl)
            elseif key == "linearVelocity" then
                local vel = b2World.b2Body_get_linearVelocity(tbl)
                return vec3(vel.x*mtpRatio, vel.y*mtpRatio)
            elseif key == "angularVelocity" then
                return deg(b2World.b2Body_get_angularVelocity(tbl))
            elseif key == "linearDamping" then
                return b2World.b2Body_get_linearDamping(tbl)
            elseif key == "angularDamping" then
                return b2World.b2Body_get_angularDamping(tbl)
            elseif key == 'interpolate' then
                --				return b2World.b2Body_get_interpolate()
            elseif key == 'sleepingAllowed' then
                return b2World.b2Body_get_sleepingAllowed()
            elseif key == 'points' then
                local vertices = {}
                local nf = b2World.b2Body_get_fixture_count(tbl)
                for j=1,nf do
                    local nv = b2World.b2Body_get_vertex_count(tbl, j-1)
                    for i=1,nv do
                        local vertex = b2World.b2Body_get_vertex(tbl, j-1, i-1)
                        vertices[#vertices+1] = vec3(
                            (vertex.x)*mtpRatio,
                            (vertex.y)*mtpRatio)
                    end
                end
                return vertices
            elseif key == 'categories' then
                local categoryBits = b2World.b2Body_get_categoryBits(tbl)
                local categories = {}
                for i=0,15 do
                    if bitAND(categoryBits, 2^i) then
                        table.add(categories, i)
                    end                    
                end
                return categories
            elseif key == 'mask' then
                local maskBits = b2World.b2Body_get_maskBits(tbl)
                local mask = {}
                for i=0,15 do
                    if bitAND(maskBits, 2^i) then
                        table.add(mask, i)
                    end                    
                end
                return mask
            elseif key == 'info' then
                return userdata[b2World.b2Body_getId(tbl)]
            else
                local result = rawget(b2Body_index, key)
                if result then
                    return result
                else
                    functionNotImplemented('physics.'..key)
                    assert(false)
                end                
            end
        end
    })

local b2Joint_index = {
    destroy = b2World.b2Joint_gc,
}

local b2Joint_mt = ffi.metatype('b2Joint', {
        __newindex = function (tbl, key, value)
            if key == 'maxMotorTorque' then
                b2World.b2Joint_set_maxMotorTorque(tbl, value)
            elseif key == 'enableMotor' then
                b2World.b2Joint_set_enableMotor(tbl, value)
            elseif key == 'motorSpeed' then
                b2World.b2Joint_set_motorSpeed(tbl, value)
            elseif key == 'enableLimit' then
                b2World.b2Joint_set_enableLimit(tbl, value)
            elseif key == 'lowerLimit' then
                b2World.b2Joint_set_lowerLimit(tbl, value*ptmRatio)
            elseif key == 'upperLimit' then
                b2World.b2Joint_set_upperLimit(tbl, value*ptmRatio)
            else
                functionNotImplemented('physics.'..key)
                --rawset(b2Body_index, key, value)
            end
        end,
        __index = function (tbl, key)
            if key == 'maxMotorTorque' then
                return b2World.b2Joint_get_maxMotorTorque(tbl)
            elseif key == 'enableMotor' then
                return b2World.b2Joint_get_enableMotor(tbl)
            elseif key == 'motorSpeed' then
                return b2World.b2Joint_get_motorSpeed(tbl)
            elseif key == 'enableLimit' then
                return b2World.b2Joint_get_enableLimit(tbl)
            elseif key == 'lowerLimit' then
                return b2World.b2Joint_get_lowerLimit(tbl)*mtpRatio
            elseif key == 'upperLimit' then
                return b2World.b2Joint_get_upperLimit(tbl)*mtpRatio
            elseif key == 'anchorA' then
                return b2World.b2Joint_get_anchorA(tbl)
            elseif key == 'anchorB' then
                return b2World.b2Joint_get_anchorB(tbl)
            else
                local result = rawget(b2Joint_index, key)
                assert(result)
                return result
            end
        end
    })

return newPhysics()
