// SymmetricEncryptor
// Token: 0x06000001 RID: 1 RVA: 0x00002050 File Offset: 0x00000450
public static void Main(string[] args)
{
	Console.WriteLine("hlS4MbOmA+kQX71xXwPs7CsCWp9jQxCPa/oMk2o2bZr+jgweD4b8u80z5LVoBqC7");
}

// SymmetricEncryptor
// Token: 0x06000002 RID: 2 RVA: 0x0000205C File Offset: 0x0000045C
public static byte[] EncryptString(string toEncrypt)
{
	byte[] array = new byte[]
	{
		5,
		18,
		61,
		44,
		125,
		34,
		247,
		90,
		155,
		149,
		103,
		142,
		219,
		199,
		5,
		231
	};
	byte[] result;
	using (Aes aes = Aes.Create())
	{
		using (ICryptoTransform cryptoTransform = aes.CreateEncryptor(array, array))
		{
			byte[] bytes = Encoding.UTF8.GetBytes(toEncrypt);
			result = cryptoTransform.TransformFinalBlock(bytes, 0, bytes.Length);
		}
	}
	return result;
}
