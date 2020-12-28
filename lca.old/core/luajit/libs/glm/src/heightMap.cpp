#include <stdio.h>
#include <string>
#include <random>

#include <glm/gtc/noise.hpp>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

typedef struct config {
    double amplitudeMax;
    double amplitudeMin;

    double octaves;
    double roughness;

    long seed;
} config;

config self = {200., 50., 4., 0.3, 10};

/*self.amplitudeMax = 200;
self.amplitudeMin = 50;

self.octaves = 4;
self.roughness = 0.3;

self.seed = 10; //random(100000000)
*/

const double pi = 3.14116;

/* This implements a Tausworthe PRNG with period 2^223. Based on:
**   Tables of maximally-equidistributed combined LFSR generators,
**   Pierre L'Ecuyer, 1991, table 3, 1st entry.
** Full-period ME-CF generator with L=64, J=4, k=223, N1=49.
*/

/* PRNG state. */
struct RandomState {
  uint64_t gen[4];	/* State of the 4 LFSR generators. */
  int valid;		/* State is valid. */
};

/* Union needed for bit-pattern conversion between uint64_t and double. */
typedef union { uint64_t u64; double d; } U64double;

/* Update generator i and compute a running xor of all states. */
#define TW223_GEN(i, k, q, s) \
  z = rs->gen[i]; \
  z = (((z<<q)^z) >> (k-s)) ^ ((z&((uint64_t)(int64_t)-1 << (64-k)))<<s); \
  r ^= z; rs->gen[i] = z;

#define U64x(hi, lo)	(((uint64_t)0x##hi << 32) + (uint64_t)0x##lo)

/* PRNG step function. Returns a double in the range 1.0 <= d < 2.0. */
uint64_t random_step(RandomState *rs)
{
  uint64_t z, r = 0;
  TW223_GEN(0, 63, 31, 18)
  TW223_GEN(1, 58, 19, 28)
  TW223_GEN(2, 55, 24,  7)
  TW223_GEN(3, 47, 21,  8)
  return (r & U64x(000fffff,ffffffff)) | U64x(3ff00000,00000000);
}

/* PRNG initialization function. */
static void random_init(RandomState *rs, double d)
{
  uint32_t r = 0x11090601;  /* 64-k[i] as four 8 bit constants. */
  int i;
  for (i = 0; i < 4; i++) {
    U64double u;
    uint32_t m = 1u << (r&255);
    r >>= 8;
    u.d = d = d * 3.14159265358979323846 + 2.7182818284590452354;
    if (u.u64 < m) u.u64 += m;  /* Ensure k[i] MSB of gen[i] are non-zero. */
    rs->gen[i] = u.u64;
  }
  rs->valid = 1;
  for (i = 0; i < 10; i++)
    random_step(rs);
}

extern "C" {
    EXPORT double getInterpolateNoise(double x, double z);
    EXPORT double getSmoothNoise(double x, double z);
    EXPORT double getNoise(double x, double z);

    EXPORT double getHeight(double x, double z) {
        double total = 0.;
        
        double d = pow(2., self.octaves-1);
        for (int i=0; i<=self.octaves-1; ++i) {
            double freq = pow(2., i) / d;
            
            double amplitudeMin = pow(self.roughness, i) * self.amplitudeMin;
            double amplitudeMax = pow(self.roughness, i) * self.amplitudeMax;
            
            double y = getInterpolateNoise(x*freq, z*freq);
            if (y >= 0.)
                total = total + y * amplitudeMax;
            else
                total = total + y * amplitudeMin;
        }
        return total;
    }

    EXPORT double interpolate(double a, double b, double blend) {
        double theta = blend * pi;
        double f = (1 - cos(theta)) * 0.5;
        return a * (1 - f) + b * f;
    }
    
    EXPORT double getInterpolateNoise(double x, double z) {
        double xInt = floor(x);
        double zInt = floor(z);

        double xFrac = x-xInt;
        double zFrac = z-zInt;

        double v1 = getSmoothNoise(xInt,    zInt);
        double v2 = getSmoothNoise(xInt+1., zInt);
        double v3 = getSmoothNoise(xInt,    zInt+1.);
        double v4 = getSmoothNoise(xInt+1., zInt+1.);

        double i1 = interpolate(v1, v2, xFrac);
        double i2 = interpolate(v3, v4, xFrac);

        double i3 = interpolate(i1, i2, zFrac);

        return i3;
    }

    EXPORT double getSmoothNoise(double x, double z) {
        double corner = (getNoise(x-1, z-1) +
            getNoise(x-1, z+1) +
            getNoise(x+1, z-1) +
            getNoise(x+1, z+1)) / 16.;

        double sides = (getNoise(x+1, z) +
            getNoise(x-1, z) +
            getNoise(x, z+1) +
            getNoise(x, z-1)) / 8.;

        double center = getNoise(x, z) / 4.;

        return corner + sides + center;
    }

//    std::default_random_engine rng;
    std::mt19937 rng;
    std::uniform_real_distribution<double> unif(-1, 1);
        
    EXPORT double getNoise1(double x, double z) {
        long seed = long(x) * 49632 + long(z) * 325176 + self.seed;
        rng.seed(seed);
        
        return unif(rng);
    }
    
    EXPORT double getNoise2(double x, double z) {
        long seed = long(x) * 49632 + long(z) * 325176 + self.seed;
        srand(seed);
        
        return 2. * (double)(rand()%RAND_MAX) / (double)RAND_MAX - 1.;
    }
    
    RandomState rs;
    
    EXPORT double getNoise(double x, double z) {
        long seed = long(x) * 49632 + long(z) * 325176 + self.seed;
        random_init(&rs, seed);
        
        U64double u;
        u.u64 = random_step(&rs);
        
        return (u.d -1.) * 2 -1;
    }
}
