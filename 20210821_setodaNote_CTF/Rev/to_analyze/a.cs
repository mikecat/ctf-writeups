using System;
using System.IO;
using System.Text;

// Token: 0x02000003 RID: 3
internal class a
{
	// Token: 0x06000004 RID: 4 RVA: 0x000020CC File Offset: 0x000002CC
	private static void a(string[] A_0)
	{
		byte[] array = new byte[]
		{
			65,
			127,
			89,
			80,
			182,
			160,
			183,
			182,
			89,
			118,
			119,
			116,
			177,
			189,
			177
		};
		for (int i = 0; i < array.Length; i++)
		{
			byte[] array2 = array;
			int num = i;
			array2[num] ^= 35;
			if (global::a.a(array[i], 119))
			{
				byte[] array3 = array;
				int num2 = i;
				array3[num2] += 3;
			}
			byte[] array4 = array;
			int num3 = i;
			array4[num3] ^= 21;
			byte[] array5 = array;
			int num4 = i;
			array5[num4] -= 32;
			array[i] = global::a.b(array[i], 39);
		}
		global::a.a(Encoding.ASCII.GetString(array), array);
	}

	// Token: 0x06000005 RID: 5 RVA: 0x0000215B File Offset: 0x0000035B
	private static byte b(byte A_0, int A_1)
	{
		if (A_1 == 114)
		{
			A_0 ^= 40;
		}
		else if (A_1 == 39)
		{
			A_0 ^= 19;
		}
		return A_0;
	}

	// Token: 0x06000006 RID: 6 RVA: 0x00002178 File Offset: 0x00000378
	private static bool a(byte A_0, int A_1)
	{
		if (A_1 == 119)
		{
			if (A_0 == 107 || A_0 == 117 || A_0 == 108 || A_0 == 102 || A_0 == 98)
			{
				return true;
			}
		}
		else if (A_0 == 110 || A_0 == 119 || A_0 == 99 || A_0 == 111 || A_0 == 97 || A_0 == 101 || A_0 == 112 || A_0 == 103 || A_0 == 108 || A_0 == 107 || A_0 == 112 || A_0 == 113)
		{
			return true;
		}
		return false;
	}

	// Token: 0x06000007 RID: 7 RVA: 0x000021E4 File Offset: 0x000003E4
	private static void a(string A_0, byte[] A_1)
	{
		if (Directory.Exists(A_0))
		{
			Console.WriteLine("Yes, that's the right answer.");
			byte[] array = new byte[]
			{
				9,
				37,
				48,
				34,
				41,
				61,
				199,
				49,
				220,
				63,
				115,
				59,
				220,
				200,
				46,
				115,
				57,
				220,
				214,
				50,
				53,
				46,
				47,
				37,
				124,
				62,
				9
			};
			for (int i = 0; i < array.Length; i++)
			{
				byte[] array2 = array;
				int num = i;
				array2[num] ^= A_1[12];
				byte[] array3 = array;
				int num2 = i;
				array3[num2] ^= A_1[8];
				byte[] array4 = array;
				int num3 = i;
				array4[num3] ^= A_1[3];
				byte[] array5 = array;
				int num4 = i;
				array5[num4] ^= 35;
				if (global::a.a(array[i], 113))
				{
					byte[] array6 = array;
					int num5 = i;
					array6[num5] += 3;
				}
				byte[] array7 = array;
				int num6 = i;
				array7[num6] ^= 21;
				byte[] array8 = array;
				int num7 = i;
				array8[num7] -= 32;
				array[i] = global::a.b(array[i], 114);
			}
			Console.WriteLine(Encoding.ASCII.GetString(array));
			return;
		}
		Console.WriteLine("nice try!");
	}
}
