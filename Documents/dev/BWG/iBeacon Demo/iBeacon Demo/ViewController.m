//
//  ViewController.m
//  iBeacon Demo
//
//  Created by Jorge Gutiérrez on 23-06-15.
//  Copyright (c) 2015 Jorge Gutiérrez. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "SecondViewController.h"



@interface ViewController (){
    NSMutableArray *des;
    NSMutableArray *tit;
    NSMutableArray *img;
    NSMutableArray *full;
    NSArray *StoagedBeacons;
    BOOL *a;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationItem.backBarButtonItem.title=@"Atras";
    a=YES;
    des=[[NSMutableArray alloc] init];
    tit=[[NSMutableArray alloc] init];
    img=[[NSMutableArray alloc] init];
    full=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets=NO;
    [full addObject:@"StorNote es una aplicación que le permite al personal de empresas suscritas hacer reportes sobre sus productos en los puntos de venta a lo largo de Chile. Ofreciendo un formato simple y amigable, en su visitas a las salas de venta el usuario puede determinar el local, asignar etiqueta, agregar fotos o una nota grabada y escribir sus observaciones, para generar y almacenar con facilidad su reporte.\nPor medio de su capacidad de geolocalización, la aplicación detecta la ubicación del usuario y propone la sala correspondiente. Al generar un nuevo reporte, el usuario puede confirmar la sala o proponer otra, incluso seleccionando a partir del mapa geolocalizada que indica todas las salas en Chile.\nLos reportes generados se pueden enviar a un correo electrónico propio o ajeno. Los usuarios podrán tener acceso a sus propios reportes y a aquellos desarrollados por otros usuarios de su empresa, buscándose por sala, fecha o autor."];
    [des addObject:@"Aplicacion Industrial"];
    [tit addObject:@"Stornote"];
    [img addObject:@"logotipo-stornote.png"];
    [des addObject:@"App movil de red social"];
    [full addObject:@"dale! revoluciona la forma en que la gente se conecta e interactúa con los demás, usando las redes sociales y la tecnología móvil. dale! es una aplicación social, interactiva, de contenidos y de funcionamiento tipo radar. Genera e incentiva conexiones entre las personas que tienen los mismos gustos y necesidades, dale te permite dejar de buscar y comenzar a jugar!"];
    [tit addObject:@"dale!"];
    [img addObject:@"dale!.png"];
    [des addObject:@"App movil de red social"];
    [full addObject:@"dale! un sueño es una aplicación móvil donde Fundación Nuestros Hijos publica los distintos sueños de los niños a los que dan soporte, con el fin de que las personas puedan revisarlos y contactarse con la fundación para cumplirlos en caso que puedan hacerlo.\nFundación Nuestros Hijos es una institución privada sin fines de lucro creada en 1991 por un grupo de padres que vivieron la experiencia de tener un hijo con cáncer.\n Agradecidos por la atención recibida, los padres se unieron para replicar esta obra en memoria de sus niños, ofreciendo un servicio de calidad absolutamente gratuito para los niños enfermos de cáncer que se atienden en el sistema público de nuestro país."];
    [tit addObject:@"dale! un sueño"];
    [img addObject:@"logodaleporun sueño.png"];
    
    [full addObject:@"Aplicación móvil de red social que te permite publicar lo que quieras en forma anónima.\nPuedes votar a favor, en contra o no votar por las publicaciones. Máximo 122 caracteres"];
    [des addObject:@"App movil de red social"];
    [tit addObject:@"BANG!"];
    [img addObject:@"logo_1024x1024.png"];
    
    
    
    
    
    StoagedBeacons=[[NSMutableArray alloc] init];
    [self init];
    if ([KTKLocationManager canMonitorBeacons])
    {
        KTKRegion *region =[[KTKRegion alloc] init];
        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
        
        [self.locationManager setRegions:@[region]];
        [self.locationManager startMonitoringBeacons];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TableViewMethods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([StoagedBeacons count]>4) {
        return 4;
    }
    else{
        return [StoagedBeacons count];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"CustomCell";
    
   
    CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    cell.image.image=[UIImage imageNamed:[img objectAtIndex:indexPath.row]];
    cell.title.text=[tit objectAtIndex:indexPath.row];
    cell.body.text=[des objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}


- (id)init
{
    self = [super init];
    
    if (self)
    {
        _locationManager = [KTKLocationManager new];
        _locationManager.delegate = self;
    }
    
    return self;
}


#pragma mark - KTKLocationManagerDelegate


- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
    }
}

//- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
//{
//    NSLog(@"Enter region %@", region.uuid);
//}
//
//- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
//{
//    NSLog(@"Exit region %@", region.uuid);
//}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
{
    NSLog(@"Ranged beacons count: %lu", (unsigned long)[beacons count]);
    if (a) {
        StoagedBeacons=beacons;
        a=!a;
    }
    if (beacons.count!=0) {
//        NSLog(@"%@",[[beacons objectAtIndex:i] minor]);
//        if (![StoagedBeacons containsObject:[[beacons objectAtIndex:0] minor]]) {
        
        if ([[StoagedBeacons objectAtIndex:0] minor] != [[beacons objectAtIndex:0] minor] ) {
            NSLog(@"hi2");
            StoagedBeacons=beacons;
            switch ([[[StoagedBeacons objectAtIndex:0] minor] intValue]) {
                    
                case 15180:
                    self.title=@"Falabella";
                    [self.sponsor setImage:[UIImage imageNamed:@"Falabella.png"]];
                    break;
                case 18839:
                    [self.sponsor setImage:[UIImage imageNamed:@"logo-sodimac.png"]];
                    self.title=@"HomeCenter";
                    break;
                case 29794:
                    [self.sponsor setImage:[UIImage imageNamed:@"Falabella.png"]];
                    self.title=@"Falabella";
                    break;
                case 28026:
                    [self.sponsor setImage:[UIImage imageNamed:@"logo-sodimac.png"]];
                    self.title=@"HomeCenter";
                    break;
                default:
                    break;
            }
            [self.beaconsTableView reloadData];
        }
        if (beacons.count==0) {
            NSLog(@"Hi");
            [self.beaconsTableView reloadData];
        }
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.beaconsTableView indexPathForSelectedRow];
    SecondViewController *destViewController = segue.destinationViewController;
    destViewController.img=[img objectAtIndex:indexPath.row];
    destViewController.des=[full objectAtIndex:indexPath.row];
}

@end
