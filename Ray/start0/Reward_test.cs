using Godot;
using System;
using System.IO.Ports;
using System.Timers;
using System.Text;


public partial class Reward_test : Godot.Node2D
{
	SerialPort Portled = new SerialPort("COM4", 9600);
	byte[] buffer = new byte[64];
	private static System.Timers.Timer aTimer;

	
	public override void _Ready()
	{
		aTimer = new System.Timers.Timer();
		Portled.Open();
		
	}

	public override void _Process(double delta)
	{
		
	}


	private void _on_button_pressed()
	{
		GD.Print("hello");
		Portled.Write("l"); //one char for one light
		byte[] buffer = new byte[5];
		Portled.Read(buffer,0,5);
		string read = System.Text.Encoding.UTF8.GetString(buffer);
		GD.Print(read);
		Portled.Close(); //must be closed or it will not open in the next trial.
	}


}


