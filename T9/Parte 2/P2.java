import java.util.Scanner;

class Veiculo{
	private String tipo;
	private String placa;
	private long entrada;
	private long saida;

	public Veiculo(String t, String p){
		this.tipo = t;
		this.placa = p;
	}

	public String getTipo(){
		return this.tipo;
	}

	public void setEntrada(){
		this.entrada = System.currentTimeMillis();
	}

	public void setSaida(){
		this.saida = System.currentTimeMillis();
	}

	public long getTime(){
		return this.saida - this.entrada;
	}
}

class Estacionamento{
	private static final double carro = 3;
	private static final double moto = 1.5;

	public Estacionamento(){}

	public double getPrice(Veiculo v){
		double time = v.getTime()/3600000; // pega o valor em horas - reduzir para minutos para testar
		if(v.getTipo().equals("carro"))
			return time * carro;
		else if(v.getTipo().equals("moto"))
			return time * moto;
		else
			return 0;
	}
}

class Drive{
	public static void main(String[] args){
		Estacionamento e = new Estacionamento();
		Scanner scan = new Scanner(System.in);

		Veiculo v1 = new Veiculo("carro","asd1234");
		System.out.println("Digite 'e' para cadastrar a entrada do primeiro veiculo!");
		scan.next();
		v1.setEntrada();
		System.out.println("Digite 's' para cadastrar a saida do primeiro veiculo!");
		scan.next();
		v1.setSaida();
		System.out.println("Valor do estacionamento para o veiculo 1 = " + e.getPrice(v1));

		Veiculo v2 = new Veiculo("moto","qwe4321");
		System.out.println("Digite 'e' para cadastrar a entrada do segundo veiculo!");
		scan.next();
		v2.setEntrada();
		System.out.println("Digite 's' para cadastrar a saida do segundo veiculo!");
		scan.next();
		v2.setSaida();
		System.out.println("Valor do estacionamento para o veiculo 2 = " + e.getPrice(v2));
	}
}