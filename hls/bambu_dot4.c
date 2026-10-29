/* Small arithmetic kernel for fully free C-to-RTL high-level synthesis.
 * Signed dot product with deliberately small input range (test vector below).
 * This is NOT a Vivado/Vitis HLS result.
 */
int dot4_bambu(int a0, int a1, int a2, int a3,
               int b0, int b1, int b2, int b3)
{
  return a0*b0 + a1*b1 + a2*b2 + a3*b3;
}
