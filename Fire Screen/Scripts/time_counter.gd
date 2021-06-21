extends Control

func change_displayed_time(t):
	if t < 0.00:
		t = 0.00
	else:
		if t > 09.99:		
			if t >= 90.00:
				$time_count1.set("frame", 9)
				t = t - 90.00
			elif t >= 80.00:
				$time_count1.set("frame", 8)
				t = t - 80.00
			elif t >= 70.00:
				$time_count1.set("frame", 7)
				t = t - 70.00
			elif t >= 60.00:
				$time_count1.set("frame", 6)
				t = t - 60.00
			elif t >= 50.00:
				$time_count1.set("frame", 5)
				t = t - 50.00
			elif t >= 40.00:
				$time_count1.set("frame", 4)
				t = t - 40.00
			elif t >= 30.00:
				$time_count1.set("frame", 3)
				t = t - 30.00
			elif t >= 20.00:
				$time_count1.set("frame", 2)
				t = t - 20.00
			elif t >= 10.00:
				$time_count1.set("frame", 1)
				t = t - 10.00
		else:
			$time_count1.set("frame", 0)
		change_displayed_time2(t)

func change_displayed_time2(t):
	if t > 00.99:
		if t >= 9.00:
			$time_count2.set("frame", 9)
			t = t - 9.00
		elif t >= 8.00:
			$time_count2.set("frame", 8)
			t = t - 8.00
		elif t >= 7.00:
			$time_count2.set("frame", 7)
			t = t - 7.00
		elif t >= 6.00:
			$time_count2.set("frame", 6)
			t = t - 6.00
		elif t >= 5.00:
			$time_count2.set("frame", 5)
			t = t - 5.00
		elif t >= 4.00:
			$time_count2.set("frame", 4)
			t = t - 4.00
		elif t >= 3.00:
			$time_count2.set("frame", 3)
			t = t - 3.00
		elif t >= 2.00:
			$time_count2.set("frame", 2)
			t = t - 2.00
		elif t >= 1.00:
			$time_count2.set("frame", 1)
			t = t - 1.00
	else:
		$time_count2.set("frame", 0)
	change_displayed_time3(t)

func change_displayed_time3(t):
	if t > 00.09:
		if t >= 0.90:
			$time_count3.set("frame", 9)
			t = t - 0.90
		elif t >= 0.80:
			$time_count3.set("frame", 8)
			t = t - 0.80
		elif t >= 0.70:
			$time_count3.set("frame", 7)
			t = t - 0.70
		elif t >= 0.60:
			$time_count3.set("frame", 6)
			t = t - 0.60
		elif t >= 0.50:
			$time_count3.set("frame", 5)
			t = t - 0.50
		elif t >= 0.40:
			$time_count3.set("frame", 4)
			t = t - 0.40
		elif t >= 0.30:
			$time_count3.set("frame", 3)
			t = t - 0.30
		elif t >= 0.20:
			$time_count3.set("frame", 2)
			t = t - 0.20
		elif t >= 0.10:
			$time_count3.set("frame", 1)
			t = t - 0.10
	else:
		$time_count3.set("frame", 0)
	change_displayed_time4(t)
			
func change_displayed_time4(t):

	if t >= 0.09:
		$time_count4.set("frame", 9)
		t = t - 0.09
	elif t >= 0.08:
		$time_count4.set("frame", 8)
		t = t - 0.08
	elif t >= 0.07:
		$time_count4.set("frame", 7)
		t = t - 0.07
	elif t >= 0.06:
		$time_count4.set("frame", 6)
		t = t - 0.06
	elif t >= 0.05:
		$time_count4.set("frame", 5)
		t = t - 0.05
	elif t >= 0.04:
		$time_count4.set("frame", 4)
		t = t - 0.04
	elif t >= 0.03:
		$time_count4.set("frame", 3)
		t = t - 0.03
	elif t >= 0.02:
		$time_count4.set("frame", 2)
		t = t - 0.02
	elif t >= 0.01:
		$time_count4.set("frame", 1)
		t = t - 0.01
	else:
		$time_count4.set("frame", 0)
