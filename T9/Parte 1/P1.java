class Ponto{
	private double x;
	private double y;

	public Ponto(){
		this.x = 0;
		this.y = 0;
	}

	public void Desloca(double desl_x, double desl_y){
		this.x = this.x + desl_x;
		this.y = this.y + desl_y;
	}

	public double getDistance(double x2, double y2){
		return Math.sqrt(Math.pow(x2 - this.x, 2) + Math.pow(y2 - this.y, 2));
	}

	public double getX(){
		return this.x;
	}

	public double getY(){
		return this.y;
	}
}

class Circle{
	private Ponto centro;
	private double raio;
	private static final double pi = 3.1415;

	public Circle(){
		this.centro = new Ponto();
		this.raio = 1;
	}

	public Circle(double init_x, double init_y, double init_raio){
		this.centro = new Ponto();
		centro.Desloca(init_x, init_y);
		this.raio = init_raio;
	}

	public double getArea(){
		return this.pi * Math.pow(this.raio, 2);
	}

	public double getDiameter(){
		return this.raio * 2;
	}

	public Ponto getCenter(){
		return this.centro;
	}

	public double getDistance(Ponto centro2){
		return this.centro.getDistance(centro2.getX(), centro2.getY());
	}
}

class Drive{
	public static void main(String[] args){
		Circle c1 = new Circle();
		System.out.println("Circulo 1\nArea = " + c1.getArea() + "\nDiametro = " + c1.getDiameter() + "\n");
		Circle c2 = new Circle(3,4,2);
		System.out.println("Circulo 2\nArea = " + c2.getArea() + "\nDiametro = " + c2.getDiameter() + "\n");
		System.out.println("Distancia entre os centros dos circulos = " + c1.getDistance(c2.getCenter()));
	}
}